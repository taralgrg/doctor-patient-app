require("sinatra")
  require("sinatra/reloader")
  also_reload("lib/**/*.rb")
  require("./lib/doctor")
  require("./lib/patient")
  require("pg")

  DB = PG.connect({:dbname => "doctor_office"})

  get("/") do
    @doctors= Doctor.all()
    erb(:index)
  end

  post("/doctors") do
    name = params.fetch("name")
    speciality = params.fetch("speciality")
    doctor = Doctor.new({:name => name, :speciality => speciality, :id => nil})
    doctor.save()
    @doctors = Doctor.all()
    erb(:index)
  end

  get("/doctors/:id") do
    @doctor = Doctor.find(params.fetch("id").to_i())
    erb(:doctor_edit)
  end

  post("/patients") do
     name = params.fetch("name")
     birthdate = params.fetch("birthdate")
     doctor_id = params.fetch("doctor_id").to_i()
     patient = Patient.new({:name => name, :birthdate => birthdate, :doctor_id => doctor_id})
     patient.save()
     @doctor = Doctor.find(doctor_id)
     erb(:doctor)
   end

   get("/patients/:id/edit") do
     @list = List.find(params.fetch("id").to_i())
     erb(:doctor_edit)
   end

   patch("/doctors/:id") do
     name = params.fetch("name")
     speciality = params.fetch("speciality")
     @doctor = Doctor.find(params.fetch("id").to_i())
     @doctor.update({:name => name, :speciality => speciality})
     erb(:doctor)
    end

   delete("/doctors/:id") do
     @doctor = Doctor.find(params.fetch("id").to_i())
     @doctor.delete()
     @doctors = Doctor.all()
     erb(:index)
   end
