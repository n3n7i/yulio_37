

function doubleind(); end;

function doubleind!(); end;



function doubleind(b::BitArray{1}, b2::BitArray{1})

  x= copy(b); x[b] .= b2; x

  end;



function doubleind(b::BitArray{1}, p::Array{Int,1})

  return (collect(1:length(b))[b])[p];

  end;


function doubleind(p::Array{Int,1}, b::BitArray{1})

  return p[b];

  end;


function doubleind(p::Array{Int,1}, p2::Array{Int,1})

  return p[p2];

  end;



function doubleind!(x::Array{Int, 1}, p::Array{Int,1}, b::BitArray{1})

  x = p[b];

  end;


function doubleind!(x::Array{Int, 1}, b::BitArray{1}, p::Array{Int,1})

  x[:] .= (collect(1:length(b))[b])[p];

  end;

##


macro yulio_Do(x)

  ## alternate 
  ## @yulio_Do scalarvec[x][y] .= z
  ## sets scalarvec


  if((x.head == :(.=)) && (x.args[1].head == :(ref)) && (x.args[1].args[1].head == :(ref)))

    x1 = x.args[1].args[1].args[1]

    x2 = x.args[1].args[1].args[2]
    
    x3 = x.args[1].args[2]

    x4 = x.args[2];

    println(x1, x2, x3, x4);

    return quote
 
      local _x1 = $(esc(x1))
      local _x2 = $(esc(x2))
      local _x3 = $(esc(x3))
      local _x4 = $(esc(x4))

      _x1[doubleind(_x2, _x3)] .= _x4;

      end;

    end;


  ## alternate 
  ## scalarvec = @yulio_Do scalarvec'''
  ## shape scalarvec to dim3 vec

  xsym = Symbol("'");

  if((x.head == xsym) && (x.args[1].head == xsym) && (x.args[1].args[1].head == xsym))

    x1 = x.args[1].args[1].args[1]

    return quote
 
      local _x1 = $(esc(x1))

      reshape(_x1, 1, 1, length(_x1))

      end;

    end;

  

  end;

