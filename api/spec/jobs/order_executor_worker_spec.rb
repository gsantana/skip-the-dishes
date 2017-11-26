describe OrderExecutorWorker do
  describe '#perform' do
    it 'performs bundle execution' do
      order = create(:customer).orders.create(deliver_late: DateTime.now)
      mailer = double(:mailer)
      expect(mailer).to receive(:deliver_later)
      expect(OrderMailer).to receive(:order_processed_email).and_return(mailer)
      job = described_class.new 
      job.perform(order.id)
      expect(order.reload.finished?).to eq(true)
    end
  end
end
