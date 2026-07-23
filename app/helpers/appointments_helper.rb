module AppointmentsHelper
  def get_color_code(status)
    color_code_hash = { scheduled: "#007bff", canceled: "#dc3545", completed: "#28a745" }
    color_code_hash[status.to_sym]
  end
end
