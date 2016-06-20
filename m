From: ajneu <ajneu1@gmail.com>
Subject: Re: Bug? -- NEVER getting =?utf-8?b?Y29udHJvbGxlci1wcm9ibGVte2JhY2stdG8tZXJyb3ItYWN0aXZlfQ==?=
Date: Mon, 20 Jun 2016 13:00:39 +0000 (UTC)
Message-ID: <loom.20160620T145908-586@post.gmane.org>
References: <loom.20160620T110554-742@post.gmane.org> <5767C65D.2010303@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:57343 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751938AbcFTNBO (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 20 Jun 2016 09:01:14 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1bEyot-0001Bg-Fh
	for linux-can@vger.kernel.org; Mon, 20 Jun 2016 15:00:51 +0200
Received: from 195.50.142.51 ([195.50.142.51])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 20 Jun 2016 15:00:51 +0200
Received: from ajneu1 by 195.50.142.51 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 20 Jun 2016 15:00:51 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Wolfgang Grandegger <wg <at> grandegger.com> writes:

> 
> Does the following patch fix both issues?
> 
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> index ce44a03..ca17ac2 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
>  <at>  <at>  -529,7 +529,7  <at>  <at>  static int
pcan_usb_fd_decode_status(struct pcan_usb_fd_if *usb_if,
>         struct peak_usb_device *dev =
usb_if->dev[pucan_stmsg_get_channel(sm)];
>         struct pcan_usb_fd_device *pdev =
>                         container_of(dev, struct pcan_usb_fd_device, dev);
> -       enum can_state new_state = CAN_STATE_ERROR_ACTIVE;
> +       enum can_state new_state;
>         enum can_state rx_state, tx_state;
>         struct net_device *netdev = dev->netdev;
>         struct can_frame *cf;
>  <at>  <at>  -547,10 +547,7  <at>  <at>  static int
pcan_usb_fd_decode_status(struct pcan_usb_fd_if *usb_if,
>                 new_state = CAN_STATE_ERROR_WARNING;
>         } else {
>                 /* no error bit (so, no error skb, back to active state) */
> -               dev->can.state = CAN_STATE_ERROR_ACTIVE;
> -               pdev->bec.txerr = 0;
> -               pdev->bec.rxerr = 0;
> -               return 0;
> +               new_state = CAN_STATE_ERROR_ACTIVE;
>         }
> 
>         /* state hasn't changed */
> 
> Wolfgang.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


Hi Wolfgang,

yes wonderful: you patch works (and solves both issues)!
Will it be going into the mainline linux kernel?

Thanks,
ajneu


PS:
Note to self: compiling module peak_usb with Wolfgang's patch

## this is under Debian (stretch)
## (I'm currently using Kernel 4.6)
sudo aptitude install build-essential
sudo aptitude install linux-source
mkdir ~/kernel
cd    ~/kernel
tar xf /usr/src/linux-source-4.6.tar.xz
cd ~/kernel/linux-source*
cp /boot/config-4.6.0-1-amd64                          .config
cp /usr/src/linux-headers-4.6.0-1-amd64/Module.symvers .
make prepare
make modules_prepare
make SUBDIRS=scripts/mod
make SUBDIRS=drivers/net/can/usb/peak_usb modules

## perform patch and then recompile with:

make SUBDIRS=drivers/net/can/usb/peak_usb modules
lsmod | grep can  ## see if previous peak_usb 
                  ## is still loaded. If this is the case then:
sudo rmmod peak_usb

## load newly compiled driver
sudo insmod drivers/net/can/usb/peak_usb/peak_usb.ko

