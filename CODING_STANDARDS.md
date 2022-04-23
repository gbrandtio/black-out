# Coding Standards
The Coding Standards of this application follow the [Common Flutter Coding Standards](https://dart.dev/guides/language/effective-dart/style).

## Design Principles
The most important design principles (minimum set of rules) that are required when contributing to this project:

1. **Single Responsibility**: Each function/class/widget should have a single responsibility.
2. **Separation of Concerns**: Each problem should be addressed on the respective layer. For example, if there is a need of a new `Handler` to handle a response,
it should be implemented in the `Services` layer and not inside a `Widget`.
3. **Open/Closed Principle**: New functionality should not alter existing classes. The classes that provide functionality should be dependent on abstractions
(e.g., Interfaces) so that the new functionality can be implemented without affecting the logic.  
> Example:
>```diff
>- DON'T                                      
>-                                            
>- ...                                        
>- RockBand rockband;                         
>- PopBand popBand;                           
>-                                            
>- public void sing(Song song){               
>-   if (song.IsRock()) rockBand.sing(song);  
>-   if (song.IsPop()) popBand.sing(song);    
>- }                                          
>```
> ```diff
> + DO                                        
> +                                           
> + ...                                       
> + List<IBand> bands;                        
> + ...                                       
> + Constructor(List<IBand> bands){           
> +   this.bands = bands;                     
> + }                                         
> + ...                                       
> + public void sing(Song song){              
> + foreach(IBand band in this.bands){        
> +   band.sing(song);                        
> + }                                         
> + ...                                       
> + public class RockBand extends IBand{      
> + ...                                       
> + public void sing(Song song){              
> +   if(canSing(song)) startSinging();       
> + }                                         
> + ...                                       
>```

## Code Style
The most important coding style standards (minimum set of rules) required:

1. Classes, Enum types, Typedefs and Type Parameters should be named using `UpperCamelCase`.
2. Extensions should also be named using `UpperCamelCase`.
3. Libraries, Packages, Directories and Source files should be named using `lowercase_with_underscores`.
4. `import` prefixes should be named using `lowercase_with_underscores`.
5. Class members, variables and named parameters should be named using `lowerCamelCase`.
6. For `const` variables both `lowerCamelCase` and `SCREAMING_CAPS` can be used. If the module already uses a `const` defined with `SCREAMING_CAPS` keep the consistency.
