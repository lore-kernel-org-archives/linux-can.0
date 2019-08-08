From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] pcan_usb_fd: zero out the common command buffer
Date: Thu, 08 Aug 2019 11:03:30 -0700 (PDT)
Message-ID: <20190808.110330.1163430543960132818.davem@davemloft.net>
References: <20190808092825.23470-1-oneukum@suse.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190808092825.23470-1-oneukum@suse.com>
Sender: netdev-owner@vger.kernel.org
To: oneukum@suse.com
Cc: netdev@vger.kernel.org, wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>
Date: Thu,  8 Aug 2019 11:28:25 +0200

> Lest we leak kernel memory to a device we better zero out buffers.
> 
> Reported-by: syzbot+513e4d0985298538bf9b@syzkaller.appspotmail.com
> Signed-off-by: Oliver Neukum <oneukum@suse.com>

Please CC: the CAN subsystem maintainers, as this is clearly listed in the
MAINTAINERS file.

Thank you.

> ---
>  drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> index 34761c3a6286..47cc1ff5b88e 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> @@ -841,7 +841,7 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev)
>  			goto err_out;
>  
>  		/* allocate command buffer once for all for the interface */
> -		pdev->cmd_buffer_addr = kmalloc(PCAN_UFD_CMD_BUFFER_SIZE,
> +		pdev->cmd_buffer_addr = kzalloc(PCAN_UFD_CMD_BUFFER_SIZE,
>  						GFP_KERNEL);
>  		if (!pdev->cmd_buffer_addr)
>  			goto err_out_1;
> -- 
> 2.16.4
> 
