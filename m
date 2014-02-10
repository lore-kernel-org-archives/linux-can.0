From: John Whitmore <arigead@gmail.com>
Subject: Re: mcp251x can't drop the can0 Interface
Date: Mon, 10 Feb 2014 22:43:55 +0000
Message-ID: <20140210224207.GB28211@griso.site>
References: <20140207201236.GB28637@griso.site>
 <52F66505.6090303@pengutronix.de>
 <20140210222543.GA28211@griso.site>
 <52F95405.9050404@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:48972 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910AbaBJWqH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Feb 2014 17:46:07 -0500
Received: by mail-we0-f171.google.com with SMTP id u56so4808139wes.16
        for <linux-can@vger.kernel.org>; Mon, 10 Feb 2014 14:46:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <52F95405.9050404@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On Mon, Feb 10, 2014 at 11:34:45PM +0100, Marc Kleine-Budde wrote:
> On 02/10/2014 11:28 PM, John Whitmore wrote:
> > Sorry for the slight delay went from the RaspberryPi 3.6 Kernel to the 3.10 to
> > see if maybe the later version worked. I'm afraid neither worked.
> 
> Your "ifplugd" is meesing around with the CAN interface.
> 
> > [   86.044493] CPU: 0 PID: 1713 Comm: ifplugd Not tainted 3.10.29-can+ #2
> > [   86.044583] [<c0013aa4>] (unwind_backtrace+0x0/0xf0) from [<c0010e00>] (show_stack+0x10/0x14)
> > [   86.044642] [<c0010e00>] (show_stack+0x10/0x14) from [<bf00ddd4>] (mcp251x_open+0x18/0x1d0 [mcp251x])
> > [   86.044694] [<bf00ddd4>] (mcp251x_open+0x18/0x1d0 [mcp251x]) from [<c0327544>] (__dev_open+0xd4/0x144)
> > [   86.044728] [<c0327544>] (__dev_open+0xd4/0x144) from [<c0327788>] (__dev_change_flags+0x88/0x130)
> > [   86.044756] [<c0327788>] (__dev_change_flags+0x88/0x130) from [<c032789c>] (dev_change_flags+0x10/0x48)
> > [   86.044795] [<c032789c>] (dev_change_flags+0x10/0x48) from [<c0381ba0>] (devinet_ioctl+0x630/0x6f8)
> > [   86.044839] [<c0381ba0>] (devinet_ioctl+0x630/0x6f8) from [<c031195c>] (sock_ioctl+0x70/0x298)
> > [   86.044882] [<c031195c>] (sock_ioctl+0x70/0x298) from [<c00dc174>] (do_vfs_ioctl+0x7c/0x5c4)
> > [   86.044913] [<c00dc174>] (do_vfs_ioctl+0x7c/0x5c4) from [<c00dc6f4>] (SyS_ioctl+0x38/0x60)
> > [   86.044947] [<c00dc6f4>] (SyS_ioctl+0x38/0x60) from [<c000db40>] (ret_fast_syscall+0x0/0x30)
> 

oops have to look into that. Learning something new every day. Thanks a
million for your help!

> Marc
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 


