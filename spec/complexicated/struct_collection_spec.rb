describe Complexicated::StructCollection do

  it 'makes selecting elements simple' do
    array_of_hashes = [
        {'first_name' => 'John', 'last_name' => 'Smith', 'salary' => 29_000},
        {'first_name' => 'Robert', 'last_name' => 'Morehouse', 'salary' => 13_000},
        {'first_name' => 'John', 'last_name' => 'Lack', 'salary' => 23_000},
        {'first_name' => 'Mary', 'last_name' => 'Greer', 'salary' => 37_000},
        {'first_name' => 'John', 'last_name' => 'Morehouse', 'salary' => 43_000},
        {'first_name' => 'Pamela', 'last_name' => 'Smith', 'salary' => 17_000},
        {'first_name' => 'Mary', 'last_name' => 'Lack', 'salary' => 7_000},
        {'first_name' => 'Robert', 'last_name' => 'Smith', 'salary' => 19_000},
        {'first_name' => 'Mary', 'last_name' => 'Smith', 'salary' => 31_000}
    ]
    complexicated = Complexicated::StructCollection.new(array_of_hashes)

    expect(complexicated.first_name('John')).to eq([{'first_name' => 'John', 'last_name' => 'Smith', 'salary' => 29_000},
                                                    {'first_name' => 'John', 'last_name' => 'Lack', 'salary' => 23_000},
                                                    {'first_name' => 'John', 'last_name' => 'Morehouse', 'salary' => 43_000}])
    expect(complexicated.first_name('John').last_name('Smith')).to eq([{'first_name' => 'John', 'last_name' => 'Smith', 'salary' => 29_000}])
    expect(complexicated.first_name('Robert', 'Pamela')).to eq([{'first_name' => 'Robert', 'last_name' => 'Morehouse', 'salary' => 13_000},
                                                                {'first_name' => 'Pamela', 'last_name' => 'Smith', 'salary' => 17_000},
                                                                {'first_name' => 'Robert', 'last_name' => 'Smith', 'salary' => 19_000}])
    expect(complexicated.first_name!('John', 'Mary')).to eq([{'first_name' => 'Robert', 'last_name' => 'Morehouse', 'salary' => 13_000},
                                                             {'first_name' => 'Pamela', 'last_name' => 'Smith', 'salary' => 17_000},
                                                             {'first_name' => 'Robert', 'last_name' => 'Smith', 'salary' => 19_000}])
    expect(complexicated.first_name!('John', 'Mary').last_name('Smith')).to eq([{'first_name' => 'Pamela', 'last_name' => 'Smith', 'salary' => 17_000},
                                                                                {'first_name' => 'Robert', 'last_name' => 'Smith', 'salary' => 19_000}])
    expect(complexicated.first_name!('John', 'Mary').last_name('Smith').pluck('salary')).to eq([17_000, 19_000])
  end

end
