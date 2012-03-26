#encoding: utf-8
require 'acceptance/acceptance_helper'

feature "Trabalhar com cadastro de usuários", :js => true do
  before do
    visit people_path
  end

  scenario "Visitar a pagina de pessoas" do
    visit people_path

    page.should have_content "Lista de pessoas"
  end

  scenario "Criar um novo camarada" do
    click_link "Nova"

    current_path.should eq "/people/new"

    page.should have_content "Nova pessoa"

    fill_in "Nome", :with => "Eric"
    select "Masculino", :from => "Sexo"
    check "Inativo?"

    click_button "Gravar"

    page.should have_content "Detalhes de: Eric"
    page.should have_content "Sexo: Masculino"
  end

  scenario "editar um camarada" do
    FactoryGirl.create(:person)

    visit people_path

    click_link "Editar"

    page.should have_field 'Nome', :with => 'Guru'
    page.should have_select 'Sexo', :selected => 'Masculino'
    page.should have_checked_field 'Inativo?'

    fill_in "Nome", :with => "GuruCE"
    select "Feminino", :from => "Sexo"
    uncheck "Inativo?"

    click_button "Gravar"

    click_link "Editar"

    page.should_not have_field 'Nome', :with => 'Guru'
    page.should_not have_checked_field 'Inativo?'
    page.should_not have_select 'Sexo', :selected => 'Masculino'

    page.should have_field 'Nome', :with => 'GuruCE'
    page.should have_select 'Sexo', :selected => 'Feminino'
  end

  scenario "Apagar camada" do
    FactoryGirl.create(:person)

    visit people_path

    page.execute_script 'this._confirm = this.confirm'
    page.execute_script 'this.confirm = function () { return true }'

    click_link "Apagar"

    page.execute_script 'this.confirm = this._confirm'

    page.should_not have_content("Guru")

  end

  scenario "mostrando o elemento escondido" do
      visit people_path

      page.find("#escondido").visible?.should be_false

      find("#mostrar").click

      page.find("#escondido").visible?.should be_true

    end

    scenario "escopo do elemento" do
      visit people_path

      page.should have_content "leu"

      within "#dentro" do
        page.should_not have_content "leu"
      end
    end
end