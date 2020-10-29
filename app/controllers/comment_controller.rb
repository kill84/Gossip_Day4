class CommentController < ApplicationController

    #   def show
    #     @comment = Comment.find(params[:gossip_id])
    #   end

      def index
        @comments = Comment.all
      end

      def new
        @comment = Comment.new
        # Méthode qui crée un potin vide et l'envoie à une view qui affiche le formulaire pour 'le remplir' (new.html.erb)
      end

      def create
        id = session[:user_id]
        if id == nil
          redirect_to new_session_path
        else
        @current_user = User.find(id)
        @comment = Comment.create('content'=> params[:content], 'user_id' => @current_user.id, 'gossip_id' => params[:gossip_id])

        if @comment.save
        redirect_to gossip_path(@comment.gossip.id)
        else
          redirect_to gossip_path(@comment.gossip.id)
        end
      end
        # Méthode qui créé un potin à partir du contenu du formulaire de new.html.erb, soumis par l'utilisateur
        # pour info, le contenu de ce formulaire sera accessible dans le hash params (ton meilleur pote)
        # Une fois la création faite, on redirige généralement vers la méthode show (pour afficher le potin créé)
      end

      def edit
        # Méthode qui récupère le potin concerné et l'envoie à la view edit (edit.html.erb) pour affichage dans un formulaire d'édition
        @comment = Comment.find(params[:id])
      end

      def update
        # Méthode qui met à jour le potin à partir du contenu du formulaire de edit.html.erb, soumis par l'utilisateur
        # pour info, le contenu de ce formulaire sera accessible dans le hash params
        # Une fois la modification faite, on redirige généralement vers la méthode show (pour afficher le potin modifié)
          @comment = Comment.find(params[:id])
          id = session[:user_id]

        #  comm_params = params.require(:comment).permit(:content, :gossip_id)
        #  @comment.update(comm_params)
        if id == @comment.user_id

          if @comment.update(content: params[:content], gossip_id: params[:gossip_id])
            redirect_to gossip_path(@comment.gossip.id)
          else
            render 'edit'
          end
        else
          redirect_to new_session_path
        end
      end

      def destroy
        # Méthode qui récupère le potin concerné et le détruit en base
        # Une fois la suppression faite, on redirige généralement vers la méthode index (pour afficher la liste à jour)
        @comment = Comment.find(params[:id])
        id = session[:user_id]

        if id == @comment.user_id

          @comment.destroy
          redirect_to gossip_path(@comment.gossip.id)
        else
          redirect_to new_session_path
        end

    end

end
