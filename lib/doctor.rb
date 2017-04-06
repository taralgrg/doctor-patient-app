class Doctor
  attr_reader(:name, :speciality, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @speciality = attributes.fetch(:speciality)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_doctors = DB.exec("SELECT * FROM doctor;")
    doctors = []
    returned_doctors.each() do |doctor|
      name = doctor.fetch("name")
      speciality = doctor.fetch("speciality")
      id = doctor.fetch("id").to_i()
      doctors.push(Doctor.new({:name => name, :speciality => speciality, :id => id}))
    end
    doctors
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO doctor (name,speciality) VALUES ('#{@name}','#{@speciality}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_doctor|
    self.name().==(another_doctor.name()).&(self.id().==(another_doctor.id())).&(self.speciality().==(another_doctor.speciality()))
  end

  define_singleton_method(:find) do |id|
    found_doctor = nil
    Doctor.all().each() do |doctor|
      if doctor.id().==(id)
        found_doctor = doctor
      end
    end
    found_doctor
  end

  define_method(:patients) do
    doctor_patients = []
    patients = DB.exec("SELECT * FROM patient WHERE doctor_id = #{self.id()};")
    patients.each() do |patient|
      name = patient.fetch("name")
      birthdate = patient.fetch("birthdate")
      doctor_id = patient.fetch("doctor_id").to_i()
      doctor_patients.push(Patient.new({:name => name, :birthdate => birthdate, :doctor_id => doctor_id}))
    end
    doctor_patients
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name)
    @speciality = attributes.fetch(:speciality)
    @id = self.id()
    DB.exec("UPDATE doctor SET name = '#{@name}' , speciality = '#{@speciality}' WHERE id = '#{self.id()}';")
    end
  end

  define_method(:delete) do
    DB.exec("DELETE FROM doctor WHERE id = #{self.id()};")
    DB.exec("DELETE FROM patient WHERE doctor_id = #{self.id()};")
  end
