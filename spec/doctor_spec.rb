require("spec_helper")

describe(Doctor) do

  describe(".all") do
    it("starts off with no doctors") do
      expect(Doctor.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("tells you its name") do
      doctor = Doctor.new({:name => "moringaschool stuff", :speciality => "general", :id => nil})
      expect(doctor.name()).to(eq("moringaschool stuff"))
    end
  end

  describe("#speciality") do
    it("tells you the speciality of the doctor") do
      doctor = Doctor.new({:name => "moringaschool stuff", :speciality => "general", :id => nil})
      expect(doctor.speciality()).to(eq("general"))
    end
  end

  describe("#save") do
    it("lets you save doctors to the database") do
      doctor = Doctor.new({:name => "moringaschool stuff", :speciality => "general", :id => nil})
      doctor.save()
      expect(Doctor.all()).to(eq([doctor]))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      doctor = Doctor.new({:name => "moringaschool stuff",:speciality => "general", :id => nil})
      doctor.save()
      expect(doctor.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#==") do
    it("is the same doctor if it has the same name") do
      doctor1 = Doctor.new({:name => "moringaschool stuff",:speciality => "general", :id => nil})
      doctor2 = Doctor.new({:name => "moringaschool stuff",:speciality => "general", :id => nil})
      expect(doctor1).to(eq(doctor2))
    end
  end

  describe(".find") do
    it("returns a doctor by its ID") do
      test_doctor = Doctor.new({:name => "Moringaschool stuff", :speciality => "general", :id => nil})
      test_doctor.save()
      test_doctor2 = Doctor.new({:name => "Home stuff", :speciality => "general", :id => nil})
      test_doctor2.save()
      expect(Doctor.find(test_doctor2.id())).to(eq(test_doctor2))
    end
  end

  describe("#patients") do
    it("returns an array of patients for that doctor") do
      test_doctor = Doctor.new({:name => "Moringaschool stuff", :speciality => "general", :id => nil})
      test_doctor.save()
      test_patient = Patient.new({:name => "Learn SQL", :birthdate => "1990-07-22", :doctor_id => test_doctor.id()})
      test_patient.save()
      test_patient2 = Patient.new({:name => "Review Ruby", :birthdate => "1991-03-11", :doctor_id => test_doctor.id()})
      test_patient2.save()
      expect(test_doctor.patients()).to(eq([test_patient, test_patient2]))
    end
  end

  describe("#update") do
    it("lets you update doctors list in the database") do
      test_doctor = Doctor.new({:name => "Moringa School stuff", :speciality => "anthropology", :id => nil})
      test_doctor.save()
      test_doctor.update({:name => "Homework stuff", :speciality => "general"})
      expect(test_doctor.name()).to(eq("Homework stuff"))
      expect(test_doctor.speciality()).to(eq("general"))
    end
  end

  describe("#delete") do
    it("lets you delete a doctor from the database") do
      doctor = Doctor.new({:name => "Moringa School stuff", :speciality => "general", :id => nil})
      doctor.save()
      doctor2 = Doctor.new({:name => "House stuff", :speciality => "anthropology", :id => nil})
      doctor2.save()
      doctor.delete()
      expect(Doctor.all()).to(eq([doctor2]))
    end

    it("deletes a doctor's patients from the database") do
      doctor = Doctor.new({:name => "Moringa School stuff", :speciality => "general", :id => nil})
      doctor.save()
      patient = Patient.new({:name => "learn SQL", :birthdate => "10-03-1992", :doctor_id => doctor.id()})
      patient.save()
      patient2 = Patient.new({:name => "Review Ruby", :birthdate => "10-03-1991", :doctor_id => doctor.id()})
      patient2.save()
      doctor.delete()
      expect(Patient.all()).to(eq([]))
    end
  end
end
