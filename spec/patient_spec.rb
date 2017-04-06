require("spec_helper")

describe(Patient) do
  describe('.all') do
    it('starts off with no patients') do
      expect(Patient.all()).to(eq([]))
    end
  end

  describe("#name") do
    it('gives patient name') do
      test_patient = Patient.new({:name => "Polo", :birthdate => "1993-11-13", :doctor_id => 1})
      expect(test_patient.name()).to(eq('Polo'))
    end
  end

  describe("#birthdate") do
    it('gives patient birthdate') do
      test_patient = Patient.new({:name => "Polo", :birthdate => "1993-11-13", :doctor_id => 1})
      expect(test_patient.birthdate()).to(eq('1993-11-13'))
    end
  end

  describe("#save") do
    it("returns an array of patients when saved") do
      test_patient = Patient.new({:name => 'Polo', :birthdate => "1993-10-30", :doctor_id => 1})
      test_patient.save()
      expect(Patient.all()).to(eq([test_patient]))
    end
  end

  describe("#doctor_id") do
    it("lets you read the doctor's ID out") do
      test_patient = Patient.new({:name => "learn SQL", :birthdate => "21-03-1993", :doctor_id => 1})
      expect(test_patient.doctor_id()).to(eq(1))
    end
  end

  describe("#==") do
    it("is the same patient if they have the same name, birthdate and Id") do
      patient1 = Patient.new({:name => 'lolo', :birthdate => "1993-10-30", :doctor_id => 1})
      patient2 = Patient.new({:name => 'lolo', :birthdate => "1993-10-30", :doctor_id => 1})
      expect(patient1).to(eq(patient2))
    end
  end
end
