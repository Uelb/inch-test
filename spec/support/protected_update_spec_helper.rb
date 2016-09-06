require 'rails_helper'

shared_examples "a protected_update" do |*protected_keys, not_protected_key|

  describe "protected_update" do
    let(:key) { protected_keys.first }
    let(:value) { "toto" }
    let(:tuple) { described_class.create }
    subject{ tuple.protected_update(key, value) }

    context "when the value is not protected" do
      let(:key) { not_protected_key }
      let(:former_value) { tuple.send(key) }
      it "updates the value" do
        expect{subject}.to change(tuple, key).from(former_value).to(value)
      end
    end

    context "when the value has already been set " do
      before(:each) do
        tuple.protected_update(key, value)
      end

      context "when it is the current value" do
        it "does not create a PastAttribute tuple" do
          expect{subject}.to change(PastAttribute, :count).by(0)
        end

        it "does not create a PastAttribute tuple with appropriate values" do
          expect{subject}.to change(PastAttribute.where(key:key, value:value, tuple:tuple), :count).by(0)
        end
      end

      context "when it is not the current value" do
        let(:current_value) { "titi" }
        before(:each) do
          tuple.protected_update(key, current_value)
        end

        it "does not update the value" do
          expect{subject}.to_not change(tuple, key)
        end

        it "does not create a PastAttribute tuple" do
          expect{subject}.to change(PastAttribute, :count).by(0)
        end

        it "does not create a PastAttribute tuple with appropriate values" do
          expect{subject}.to change(PastAttribute.where(key:key, value:value, tuple:tuple), :count).by(0)
        end
      end

      context "when setting a different value" do
        let(:new_value) { "titi" }
        subject{ tuple.protected_update(key, new_value) }

        it "updates the value" do
          expect{subject}.to change(tuple, key).from(value).to(new_value)
        end

        it "creates a PastAttribute tuple" do
          expect{subject}.to change(PastAttribute, :count).by(1)
        end

        it "creates a PastAttribute tuple with appropriate values" do
          expect{subject}.to change(PastAttribute.where(key:key, value:new_value, tuple:tuple), :count).by(1)
        end
      end
    end

    context "when the value has never been set" do
      it "creates a PastAttribute tuple" do
        expect{subject}.to change(PastAttribute, :count).by(1)
      end

      it "updates the value" do
        expect{subject}.to change(tuple, key).from(nil).to(value)
      end

      it "creates a PastAttribute tuple with appropriate values" do
        expect{subject}.to change(PastAttribute.where(key:key, value:value, tuple:tuple), :count).by(1)
      end
    end
  end

end