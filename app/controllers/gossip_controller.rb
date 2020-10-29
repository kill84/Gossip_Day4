class GossipController < ApplicationController

  def show
    id = params[:id]
    @gossipfind = Gossip.find(params[:id])
    @comments = @gossipfind.comments
  end

  def index
    @gossips = Gossip.all
  end

  def new
    @gossip = Gossip.new
    # Méthode qui crée un potin vide et l'envoie à une view qui affiche le formulaire pour 'le remplir' (new.html.erb)
  end

  def create
    id = session[:user_id]
    if id == nil
      redirect_to new_session_path
    else

    current_user = User.find(id)
    @gossip = Gossip.create('title' => params[:title], 'content'=> params[:content], 'user_id' => current_user.id)


    if @gossip.save
    redirect_to gossip_path(@gossip.id)
    flash[:notice]= "Post successfully created"
    else
      flash[:alert] = "Post aborted"
      render 'new'
    end
  end
    # Méthode qui créé un potin à partir du contenu du formulaire de new.html.erb, soumis par l'utilisateur
    # pour info, le contenu de ce formulaire sera accessible dans le hash params (ton meilleur pote)
    # Une fois la création faite, on redirige généralement vers la méthode show (pour afficher le potin créé)
  end

  def edit
    # Méthode qui récupère le potin concerné et l'envoie à la view edit (edit.html.erb) pour affichage dans un formulaire d'édition
    @gossip = Gossip.find(params[:id])
  end

  def update
    # Méthode qui met à jour le potin à partir du contenu du formulaire de edit.html.erb, soumis par l'utilisateur
    # pour info, le contenu de ce formulaire sera accessible dans le hash params
    # Une fois la modification faite, on redirige généralement vers la méthode show (pour afficher le potin modifié)
    @gossip = Gossip.find(params[:id])
    id = session[:user_id]
    if id == @gossip.user_id

      post_params = params.require(:gossip).permit(:title, :content)
      @gossip.update(post_params)
        if @gossip.update(post_params)
          redirect_to gossip_path(@gossip.id)
          flash[:notice]= "Post successfully created"
        else
          flash[:alert] = "Post aborted"
          render 'edit'
        end

    else
      redirect_to new_session_path
    end

  end

  def destroy
    # Méthode qui récupère le potin concerné et le détruit en base
    # Une fois la suppression faite, on redirige généralement vers la méthode index (pour afficher la liste à jour)
    @gossip = Gossip.find(params[:id])
    id = session[:user_id]
    if id == @gossip.user_id

      @gossip.destroy
      redirect_to root_path
      flash[:notice]= "Post successfully deleted"
    else
      redirect_to new_session_path
    end
  end

end
