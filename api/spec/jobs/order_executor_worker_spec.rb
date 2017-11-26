describe OrderExecutorWorker do
  describe '#perform' do
    it 'performs bundle execution' do
      order = create(:customer).orders.create(deliver_late: DateTime.now)
      job = described_class.new 
      job.perform(order.id)
      expect(order.reload.finished?).to eq(true)
    end
  end
end
