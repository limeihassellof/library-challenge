require './lib/library.rb'

describe Library do

  it 'is an array' do
    expect(subject.book_list).to be_instance_of(Array)
  end

  it 'return a collection of 1 or more books' do
    expect(subject.book_list.length).to be > 0
  end

  it 'allow check_out of book' do
    expected_output = { status: true, message: 'check_out complete', book_id: 1234, date: Date.today, return_date: Date.today.next_month }
    expect(subject.perform_check_out(1234)).to eq expected_output
  end

  it 'reject check_out of book if the book not avaialble' do
    subject.perform_check_out(1234)

    expected_output = {status: false, message: 'book unavailable', book_id: 1234}
    expect(subject.perform_check_out(1234)).to eq expected_output
  end

  it 'return date should be 30 days in future when on check out' do
    expected_output = {status: true, message: 'check_out complete', book_id: 1234, date: Date.today, return_date: Date.today.next_month }
    expect(subject.perform_check_out(1234)).to eq expected_output
  end

  it 'allow me to return a book' do
     subject.perform_check_out(1234)
     expected_output = {status: true, book_id: 1234, return_date: Date.today, message: "book returned"}
     expect(subject.perform_return(1234)).to eq expected_output
  end

  it 'can see when book is going to be returned' do
    subject.perform_check_out(1234)
    book = subject.book_list.find {|b| b[:book_id] == 1234}
    expect(book[:return_date]).to eq Date.today.next_month
  end
end
