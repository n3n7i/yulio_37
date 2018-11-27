

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

  if((x.head == :(.=)) && (x.args[1].head == :(ref)) && (x.args[1].args[1].head == :(ref)))

    x1 = eval(x.args[1].args[1].args[1])

    x2 = eval(x.args[1].args[1].args[2])
    
    x3 = eval(x.args[1].args[2])

    x4 = eval(x.args[2]);

    zx = doubleind(x2, x3);

    return :($(x1)[$zx] .= $(x4));

    end;

  end;


