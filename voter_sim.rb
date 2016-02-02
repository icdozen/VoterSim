#Our two sample arrays. One to store data on the politicians and one for voters.
  @politicians = [
    { name: "Marco Rubio",
      party: "Republican" },
    { name: "Bernie Sanders",
      party: "Democrat" }
    ]
  @voters = [
    { name: "Bob Sagget",
      politics: "Tea Party" },
    { name: "Larry David",
      politics: "Liberal" }
    ]

#Method used by our List method to present the names in nicer format.
#Uses two loops to go through the arrays.
  def pretty_display

    @politicians.each do |member|
      puts "* Politician, #{member[:name]}, #{member[:party]} "
    end

    @voters.each do |member|
      puts "* Voter, #{member[:name]}, #{member[:politics]} "
    end
  end

#Method called at the end of create, list, update and delete that confirms if user is done.
#If yes, it exits the program. If no, takes user back to main menu.

  def finish
    puts "Are you satisfied...yet?"
    puts "(Y)es or (N)o"
    input = gets.strip.downcase
    if input == "y"
      puts "THANK YOU"
      exit
    elsif input == "n"
      main_menu
    else
      puts "I'm not sure what to do here"
      main_menu
    end
  end


#Method that breaks up the screen for asthetics.
  def put_a_line
    puts "\n"
    puts "/\\" * 40
    puts "\n"
  end

#Method that starts the program. Contains 4 other methods, one for each menu option.
#Main menu is called again if invalid user input.
  def main_menu
    put_a_line
    puts "What would you like to do?"
    puts "(C)reate, (L)ist, (U)pdate, or (D)elete"
    put_a_line
    main_menu_selection = gets.chomp.downcase

    case main_menu_selection
      when "c"
        create
      when "l"
        list
      when "u"
        update
      when "d"
        delete
#If user input is wrong, it starts them back at the main menu.
      else
        puts "Invalid entry."
        main_menu
    end
  end

#Method that handles the functionality of adding a politician or voter into the database.
  def create

    put_a_line
    puts "What would you like to create? Choose a letter."
    puts "(P)olitician or (V)oter"
    put_a_line
    create_selection = gets.chomp.downcase
#If user wants to add a politician. After collecting name and party the politician is stored in a hash which is stored in the politicians array.
    if create_selection == "p"
      print "Enter Politicians FIRST and LAST name:  "
      p_name = gets.split.each{|i| i.capitalize!}.join(' ')
      print """Enter the new political party:
      (R)epublican, (D)emocrat
      """
      p_party = gets.strip.downcase
      if p_party == "r"
        p_party = "Republican"
        @politicians << {name: p_name, party: p_party }
      elsif p_party == "d"
        p_party = "Democrat"
        @politicians << {name: p_name, party: p_party }
      else
        puts "Please try again."
        create
      end
#If user wants to add a voter. After collecting name and politics the voter is stored in a hash which is stored in the voters array.
    elsif create_selection == "v"
        print "Enter Voter's FIRST and LAST name: "
        v_name = gets.split.each{|i| i.capitalize!}.join(' ')
        print """Enter the new political view:
        (C)onservative, (L)iberal, (S)ocialist,
        (T)ea Party, or (N)eutral
        """
        v_party = gets.strip.downcase
        if v_party == "c"
          v_party = "Conservative"
          @voters << {name: v_name, politics: v_party }
        elsif v_party == "l"
          v_party = "Liberal"
          @voters << {name: v_name, politics: v_party }
        elsif v_party == "s"
          v_party = "Socialist"
          @voters << {name: v_name, politics: v_party }
        elsif v_party == "t"
          v_party = "Tea Party"
          @voters << {name: v_name, politics: v_party }
        elsif v_party == "n"
          v_party = "Neutral"
          @voters << {name: v_name, politics: v_party }
        else
          puts "Please try again."
          create
        end
      else
        puts "Invalid entry"
        create
    end
    finish
  end

#Method for the List option. Functionality and presentation is handled pretty display method.
  def list
    put_a_line
    pretty_display
    put_a_line
    finish
  end

#Method that handles the functionality of updating information on an existing politician/voter.

def update
    put_a_line
    puts "Who would you like to update?"
    print "Full Name: "
    select_name = gets.split.each{|i| i.capitalize!}.join(' ')
#Takes user's input and searches inside the politicians array for the hash with key name that matches.
    if @politicians.find {|i| i[:name] == select_name}
      puts "What would you like to update?"
      puts "Options: (N)ame, (P)arty, or (B)oth"
      options = gets.strip.downcase
#Cases depending on user input.
      case options
#To update a name. Uses a loop. Takes user data and updates the values in the hash if it matches.
        when "n"
          print "Enter the new FIRST and LAST name: "
          new_name = gets.split.each{|i| i.capitalize!}.join(' ')
          @politicians.each {|k| k[:name] = new_name if k[:name] == select_name}
          finish
#To update a party. Uses a loop. Takes user data and updates the values in the hash if it matches.
        when "p"
          print """Enter the new political party:
          (R)epublican, (D)emocrat
          """
          new_politics = gets.strip.downcase
          if new_politics == "r"
            new_politics = "Republican"
            @politicians.each {|k| k[:party] = new_politics if k[:name] == select_name}
            finish

          elsif new_politics == "d"
            new_politics = "Democrat"
            @politicians.each {|k| k[:party] = new_politics if k[:name] == select_name}
            finish
          else
            puts "Please try again."
            update
          end

#To update both the name and the party. Uses same code as above. Takes user data and updates the values in the hash if it matches.
        when "b"

          print "Enter the new FIRST and LAST name: "
          new_name = gets.split.each{|i| i.capitalize!}.join(' ')

          print """Enter the new political party:
          (R)epublican, (D)emocrat
          """
          new_politics = gets.strip.downcase

          if new_politics == "r"
            new_politics = "Republican"
#Updates the array/hash with new party.
            @politicians.each {|k| k[:party] = new_politics if k[:name] == select_name}

          elsif new_politics == "d"
            new_politics = "Democrat"
#Updates the array/hash with new party.
            @politicians.each {|k| k[:party] = new_politics if k[:name] == select_name}

          else
            puts "Please try again."
            update
          end
#Updates the array/hash with new name.
          @politicians.each {|k| k[:name] = new_name if k[:name] == select_name}

          finish

        else
          puts "Invalid entry."
          update
        end
#Takes user's input and searches inside the politicians array for the hash with key name that matches.
    elsif @voters.find {|i| i[:name] == select_name}

      puts "What would you like to update?"
      puts "Options: (N)ame, (P)olitics, or (B)oth"

      options = gets.strip.downcase
      case options
#To update a name. Uses a loop. Takes user data and updates the values in the hash if it matches.
        when "n"
          print "Enter new FIRST and LAST name: "
          new_name = gets.split.each{|i| i.capitalize!}.join(' ')
          @voters.each {|k| k[:name] = new_name if k[:name] == select_name}
          finish
#To update polotics. Uses a loop. Takes user data and updates the values in the hash if it matches.
        when "p"
          print """Enter the new political view:
          (C)onservative, (L)iberal, (S)ocialist,
          (T)ea Party, or (N)eutral
          """
          new_politics = gets.strip.downcase
          if new_politics == "c"
            new_politics = "Conservative"

          elsif new_politics== "l"
            new_politics = "Liberal"

          elsif new_politics == "s"
            new_politics = "Socialist"

          elsif new_politics == "t"
            new_politics = "Tea Party"

          elsif new_politics == "n"
            new_politics = "Neutral"

          else
            puts "Please try again."
            update
          end

          @voters.each {|k| k[:politics] = new_politics if k[:name] == select_name}
          finish
#To update both the name and the politics. Uses same code as above. Takes user data and updates the values in the hash if it matches.
        when "b"
          print "Enter the new FIRST and LAST name: "
          new_name = gets.split.each{|i| i.capitalize!}.join(' ')

          print """Enter the new political view:
          (C)onservative, (L)iberal, (S)ocialist,
          (T)ea Party, or (N)eutral
          """
          new_politics = gets.strip.downcase
          if new_politics == "c"
            new_politics = "Conservative"
            @voters.each {|k| k[:politics] = new_politics if k[:name] == select_name}

          elsif new_politics== "l"
            new_politics = "Liberal"
            @voters.each {|k| k[:politics] = new_politics if k[:name] == select_name}

          elsif new_politics == "s"
            new_politics = "Socialist"
            @voters.each {|k| k[:politics] = new_politics if k[:name] == select_name}

          elsif new_politics == "t"
            new_politics = "Tea Party"
            @voters.each {|k| k[:politics] = new_politics if k[:name] == select_name}

          elsif new_politics == "n"
            new_politics = "Neutral"
            @voters.each {|k| k[:politics] = new_politics if k[:name] == select_name}

          else
            puts "Please try again."
            update
          end

          @voters.each {|k| k[:name] = new_name if k[:name] == select_name}
          finish

        else
          puts "Invalid entry."
          update
        end
#If user searches name that isn't in the hashes it asks if they would like to
      else
        puts "User not in database"
        puts "Would you like to add a name?"
        puts "(Y)es or (N)o?"
        add_name = gets.strip.downcase
        if add_name == "y"
          create
        elsif add_name == "n"
          main_menu
        else
          puts `say stop trying to break me fool.`
          puts "Invalid entry."
          main_menu
      end
      finish
    end
  end

#Method that handles the functionality of deleting an existing politician/voter from the arrays.

  def delete
      put_a_line
      puts "Who would you like to delete?"
      print "Name: "
      select_name = gets.split.each{|i| i.capitalize!}.join(' ')
#Takes the user input and searches both the voter and politicians array for a matching hash.
      if @voters.find {|i| i[:name] == select_name} || @politicians.find {|i| i[:name] == select_name}
        puts "Are you sure? (Y)es or (N)o"
        delete_entry = gets.strip.downcase
        if delete_entry == "y"
#If user confirms deleting, they are removed from the hash here.
          @politicians.delete_if { |i| i[:name] == select_name }
          @voters.delete_if { |i| i[:name] == select_name }
          puts "#{select_name} has successfully been deleted."
        elsif delete_entry == "n"
          main_menu
        else
          puts "Invalid entry"
          delete
        end
      else
        puts "Invalid entry"
        delete
      end
      finish
    end

#Calls the method that launches the program.
main_menu
