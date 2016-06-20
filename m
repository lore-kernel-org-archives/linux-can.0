From: ajneu <ajneu1@gmail.com>
Subject: Re: Bug? -- NEVER getting =?utf-8?b?Y29udHJvbGxlci1wcm9ibGVte2JhY2stdG8tZXJyb3ItYWN0aXZlfQ==?=
Date: Mon, 20 Jun 2016 09:22:49 +0000 (UTC)
Message-ID: <loom.20160620T112016-679@post.gmane.org>
References: <loom.20160620T110554-742@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:38511 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753771AbcFTJXG (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 20 Jun 2016 05:23:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1bEvQ4-0007yw-S7
	for linux-can@vger.kernel.org; Mon, 20 Jun 2016 11:23:01 +0200
Received: from 195.50.142.51 ([195.50.142.51])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 20 Jun 2016 11:23:00 +0200
Received: from ajneu1 by 195.50.142.51 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 20 Jun 2016 11:23:00 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

ajneu <ajneu1 <at> gmail.com> writes:
> I'm using a PEAK USB Adapter (PCAN-USB FD) for normal CAN Frames (standard
> format), and lsmod shows peak_usb as it should.
> 
> When running on a can bus and continually send out messages (one frame each
> second).
> But there is no other participant, so I will get NO ACK.
> 
> So berr-counter-tx counts up until it reaches
> 96:
> -> enter state ERROR-WARNING.
> 
>    I then get a frame:
>    Error: 
> 	Id  : 0x20000004
> 	Data: 0x0 0x8 0x0 0x0 0x0 0x0 0x0 0x0 
> 	controller-problem{tx-error-warning}
> [...]

I should mention which settings I'm using (I hope the settings are ok.)

        const can_err_mask_t err_mask =
            ( CAN_ERR_TX_TIMEOUT   /* TX timeout (by netdevice driver) */
            | CAN_ERR_LOSTARB      /* lost arbitration    / data[0]    */
            | CAN_ERR_CRTL         /* controller problems / data[1]    */
            | CAN_ERR_PROT         /* protocol violations / data[2..3] */
            | CAN_ERR_TRX          /* transceiver status  / data[4]    */
            | CAN_ERR_ACK          /* received no ACK on transmission */
            | CAN_ERR_BUSOFF       /* bus off */
            //CAN_ERR_BUSERROR     /* bus error (may flood!) */
            | CAN_ERR_RESTARTED    /* controller restarted */
        );

        ret = setsockopt(sock_fd, SOL_CAN_RAW, CAN_RAW_ERR_FILTER,
&err_mask, sizeof(err_mask));


AND

        // Write should block, when socketcan's own queue is full.
        // To have this behaviour (and not get error ENOBUFS) set SO_SNDBUF
to its minimum value.
        // See https://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf#page=21
        const int sndbuf = 0;
        if (setsockopt(sock_fd, SOL_SOCKET, SO_SNDBUF, &sndbuf,
sizeof(sndbuf)) < 0) {
            std::cerr << "Error setting SO_SNDBUF in setsockopt" <<
std::strerror(errno) << std::endl;
            return -1;
        }

