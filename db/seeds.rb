Admin.find_or_create_by(id: 1) do |admin|
  admin.email = "d01masatooo11@gmail.com"
  admin.password = "masato1201"
end

Expert.find_or_create_by(id: 1) do |expert|
  expert.email = "d01masatooo11@gmail.com"
  expert.password = "masato1201"
end