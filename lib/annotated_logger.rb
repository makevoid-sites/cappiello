class AnnotatedLogger < Logger

  def initialize(*args)
    super *args
    label = if Rails.env == "production"
      Rails.root.to_s.match(/^\/www\/(\w+)\//)[1]
    else
      Rails.root.to_s.split("/")[-1]
    end
    
    [:info, :debug, :warn, :error, :fatal].each {|m|
      AnnotatedLogger.class_eval %Q|
      def #{m} arg=nil, &block
        if block_given?
          arg = yield
        end
        mex = arg.gsub(/\n/,"\n#{label}:")
        super "#{label}: %s" % mex
      end
      |

    }
  end
end
