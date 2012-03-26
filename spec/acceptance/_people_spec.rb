#encoding: utf-8
require 'acceptance/acceptance_helper'

feature "Trabalhar com crud de pessoas", :js => true do
  before do
  end

  scenario "visitar a pagina inicial de pessoa" do
    visit people_path
    page.should have_content "Lista de pessoas"
  end

  scenario "criar um novo usuário" do
    visit people_path

    click_link "Nova"

    page.should have_content "Nova pessoa"

    fill_in "Nome", :with => "Guru"
    select "Masculino", :from => "Sexo"
    check "Inativo?"

    click_button "Gravar"

    page.should have_content "Detalhes de: Guru"
    page.should have_content "Sexo: Masculino"
    page.should have_content "Inativo: Sim"
  end

  scenario "editar uma pessoa" do
    FactoryGirl.create(:person)

    visit people_path

    click_link "Editar"

    page.should have_field 'Nome', :with => 'Guru'
    page.should have_checked_field 'Inativo?'
    page.should have_select 'Sexo', :selected => 'Masculino'

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

  scenario "Apagar uma pessoa" do
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

    page.find("#escondido").visible?.should_not be_true

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