require 'cantango/configuration/shared/role_registry_ex'

shared_examples_for 'System' do  
  it_should_behave_like "Role Registry"
  
  describe 'default system - simple_roles' do
    its(:system) { should == :simple_roles }    
  end
  
  describe 'system=' do
    before do
      subject.system = :my_sys
    end
    its(:system) { should == :my_sys }
  end  
  
  describe 'system_apis=' do
    let(:my_own_sys) do 
      {:my_own_sys => {:list => :listing } }
    end

    before do
      subject.system_apis = my_own_sys
      subject.system = :my_own_sys
    end

    specify { subject.system_api[:list].should == :listing }
    specify { subject.system_apis.size.should == 1 }
  end
  
  describe 'add_systems' do
    before do
      subject.add_system :my_other_sys => {:list => :listing }
      subject.system = :my_other_sys
    end
    specify { subject.system_api[:list].should == :listing }
    specify { subject.system_apis.size.should > 1 }
  end
end