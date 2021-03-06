describe PostsController do
  # describe '#create' do
  #   context 'regular user' do
  #     before do
  #       sign_in!
  #     end
  #
  #     it 'allows any user to to create a post' do
  #       created_post = create(:post, content: 'bar')
  #
  #       expect {
  #         post :update, id: created_post.id, post: { content: 'foo' }
  #       }.not_to change(created_post, :content)
  #     end
  #   end

  describe '#update' do
    context 'neither admin nor vip' do
      before do
        sign_in!
      end

      it 'does not allow the request' do
        created_post = create(:post, content: 'bar')

        expect {
          post :update, id: created_post.id, post: { content: 'foo' }
        }.not_to change(created_post, :content)
      end
    end

    context 'vip' do
      before do
        sign_in!('vip')
      end

      it 'allows the request' do
        created_post = create(:post, content: 'bar')

        post :update, id: created_post.id, post: { content: 'foo' }

        expect(created_post.reload.content).to eq('foo')
      end
    end

    context 'admin' do
      before do
        sign_in!('admin')
      end

      it 'allows the request' do
        created_post = create(:post, content: 'bar')

        post :update, id: created_post.id, post: { content: 'foo' }

        expect(created_post.reload.content).to eq('foo')
      end
    end
  end
end
