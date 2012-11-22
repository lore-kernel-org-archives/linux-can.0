From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6] can: kvaser_usb: Add support for Kvaser CAN/USB
 devices
Date: Thu, 22 Nov 2012 13:30:22 -0800
Message-ID: <20121122213022.GB1461@kroah.com>
References: <1343626352-24760-1-git-send-email-olivier@sobrie.be>
 <1353481873-3214-1-git-send-email-olivier@sobrie.be>
 <20121122150149.GB11612@hposo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121122150149.GB11612@hposo>
Sender: netdev-owner@vger.kernel.org
To: Olivier Sobrie <olivier@sobrie.be>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, Daniel Berglund <db@kvaser.com>
List-Id: linux-can.vger.kernel.org

On Thu, Nov 22, 2012 at 04:01:49PM +0100, Olivier Sobrie wrote:
> Hi linux-usb folks,
> 
> Is there someone who can help me to fix the following errors?
> 
> smatch warnings:
> 
> + drivers/net/can/usb/kvaser_usb.c:431 kvaser_usb_send_simple_msg() error: doing
> +dma on the stack ((null))
> + drivers/net/can/usb/kvaser_usb.c:1073 kvaser_usb_set_opt_mode() error: doing
> +dma on the stack ((null))
> + drivers/net/can/usb/kvaser_usb.c:1174 kvaser_usb_flush_queue() error: doing
> +dma on the stack ((null))
> + drivers/net/can/usb/kvaser_usb.c:1384 kvaser_usb_set_bittiming() error: doing
> +dma on the stack ((null))
> 
> I assume it's due to the buffer I pass to the function usb_bulk_msg()
> which is on the stack and can't be.
> Do I just have to kmalloc a buffer and give it to the usb_bulk_msg()
> function? That's what I understood by reading
> "Documentation/DMA-API-HOWTO.txt" section "What memory is DMA'able?"...
> and from commit
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=32ec4576c3fb37316b1d11a04b220527822f3f0d

Yes, that is all that is needed.

thanks,

greg k-h
