department(_d_name _, _dabbreviations_)
unique(dabbreviations)

program(_p_name ,  p_abbreviations)


StudentBelongsTo(_s_idnr_, s_name , _p_name _,  b_name , login)
(p_name , b_name ) -> branch(p_name , b_name )
unique(login)

RegisteredStudent(_s_idnr_,_code_, grade, position)
unique(code)
unique(position)

Courseinformation(_code_, cname, credits, d_name , capacity)
d_name -> department(d_name) 
code -> courses.code

Classification(_cname_,_code_, _position_ )
code -> courses.code
(code, position) -> RegisteredStudent(code, posistion)



