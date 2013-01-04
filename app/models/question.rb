class Question < ActiveRecord::Base
  attr_accessible :a, :answer, :b, :c, :d, :difficulty

end


def generatequestions
 number_array = ["1.0","2.0","3.0","4.0","5.0","6.0","7.0","8.0","9.0"]
# number_array = ["1.0", "4.0","5.0","6.0"]
  
  operators = [" + ", " - ", " * ", " / "]
  openparens = [" ", "(", "(("]
   
   
  number_array.each do |a|
    openparens.each do |openparen1|
      operators.each do |operator1|
        block1 = openparen1 + a + operator1
        if block1.count("(") > block1.count(")")
          closeparens2 = [" ", ")"]
        else
          closeparens2 =[" "]
        end
          
        number_array.each do |b|
          openparens.each do |openparen2|
            operators.each do |operator2|
              closeparens2.each do |closeparen2|
                   
                block2 =  block1 + openparen2 + b + closeparen2 + operator2    
                case block2.count("(") - block2.count(")")
                when 2
                  closeparens3 = [" ", ")", "))"]
                when 1
                  closeparens3 = [" ", ")"]
                else
                  closeparens3 =[" "]
                end
                     
                number_array.each do |c|
                  [" ", "("].each do |openparen3|
                    operators.each do |operator3|                   
                      closeparens3.each do |closeparen3|
                             
                        block3 =  block2 + openparen3 + c + closeparen3 + operator3 
                        case (block3.count("(") - block3.count(")"))
                        when 0
                          closeparen4 = " "
                        when 1
                           closeparen4 = ")"
                        when 2
                           closeparen4 ="))"
                        else
                            closeparen4 ="xxx"
                        end
                        number_array.each do |d|
                          block4 = block3 + d + closeparen4
                          
                          # cases to throw out!!!!
                          if (openparen2 == "(" and closeparen2 == ")") or 
                            (closeparen2 == ")" and (operator1 == " * " or operator1 == " / ")) or
                            (not openparen2 == " " and not closeparen2 == " ") or
                            (not openparen3 == " " and not closeparen3 == " ") or
                            ((not openparen1 == " ") and closeparen2 == " " and closeparen3 == " ") or
                            ((openparen1 == "((" or openparen2 == "((") and (closeparen3 == "))" or closeparen4 =="))")) or
                            (openparen3 == "("  and closeparen3 == ")") or
                            (openparen3 == "("  and closeparen4 == ")" and operator3 == " * " and (operator2 == " + " or operator2 == " * ")) or
                            (openparen1 == "("  and closeparen4 == ")" and openparen2 == " " and openparen3 == " ") or
                            (openparen2 == "("  and operator1 == " + ") or
                            (closeparen4 == "xxx") or
                            (operator1 == " / " and a < b and openparen2 == " ") or
                            (operator2 == " / " and b < c and closeparen2 == " " and openparen3 == " ") or
                            (operator3 == " / " and c < d and closeparen3 == " ") or
                            ((operator1 == " * " or operator1 == " + " or operator1 == " - ") and (openparen2 == "(" and closeparen3 ==")" and operator2 == " * ")) or
                            (closeparen3 == ")" and (operator3 == " + " or operator3 == " - ")) or                            
                            (openparen1 == "("  and closeparen2 == ")" and (operator1 == " * " or operator1 == " / ")) or
                            (openparen1 == "(("  and closeparen2 == ")" and (operator1 == " * " or operator1 == " / ")) or
                            ((operator1 == " + " or operator1 == " - ") and (operator2 == " + " or operator2 == " - ") and (operator3 == " + " or operator3 == " - ") and not (openparen1 == " " and openparen2 == " " and openparen3 == " " )) or 
                            ((operator1 == " * " and operator2 == " * " and operator3 == " * ") and not (openparen1 == " " and openparen2 == " " and openparen3 == " " ))
                                                  
                          else
                            answer = openparen1 + a.first + operator1 + openparen2 + b.first + closeparen2 + operator2 + openparen3 + c.first + closeparen3 + operator3 + d.first + closeparen4                            
                            #puts block4 + " --- " + answer
                            
                            if eval(block4) == 24 
                              #if eval(answer) == 24  
                                nums = [a, b, c, d].sort
                                searchstring = "a="+ nums[0] + " and b="+ nums[1] + " and c=" + nums[2] + " and d=" + nums[3]
                            
                                oldq = Question.where(searchstring)
                                #answer = openparen1 + a.first + operator1 + openparen2 + b.first + closeparen2 + operator2 + openparen3 + c.first + closeparen3 + operator3 + d.first + closeparen4                            
                              
                                if oldq.length == 0
                                  newq = Question.new 
                                  newq.answer = "--- " + answer + " <"+block4+"> "
                                  newq.difficulty = 1
                                  answer = answer  + " ********** "
                              
                                else 
                                  newq = oldq.first
                                  newq.answer = newq.answer + " ***** " + answer+ " <"+block4+"> "
                                  newq.difficulty = newq.difficulty + 1                    
                                end
                                newq.a = eval(nums[0])
                                newq.b = eval(nums[1])
                                newq.c = eval(nums[2])
                                newq.d = eval(nums[3])
                                puts answer
                                newq.save
                              #end
                                
                            end
                          end
                        end
                         
                      end
                    end
                  end
                end
              end         
            end
          end
        end
      end 
    end
  end
end
