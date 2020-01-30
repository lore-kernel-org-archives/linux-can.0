From: Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH] bonding: do not enslave CAN devices
Date: Thu, 30 Jan 2020 14:41:41 +0100
Message-ID: <20200130134141.GA804563@bistromath.localdomain>
References: <20200130133046.2047-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21533 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726996AbgA3Nlw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 30 Jan 2020 08:41:52 -0500
In-Reply-To: <20200130133046.2047-1-socketcan@hartkopp.net>
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, syzbot+c3ea30e1e2485573f953@syzkaller.appspotmail.com, dvyukov@google.com, mkl@pengutronix.de, j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net, davem@davemloft.net, linux-stable <stable@vger.kernel.org>

Hello,

2020-01-30, 14:30:46 +0100, Oliver Hartkopp wrote:
> Since commit 8df9ffb888c ("can: make use of preallocated can_ml_priv for per
> device struct can_dev_rcv_lists") the device specific CAN receive filter lists
> are stored in netdev_priv() and dev->ml_priv points to these filters.
> 
> In the bug report Syzkaller enslaved a vxcan1 CAN device and accessed the
> bonding device with a PF_CAN socket which lead to a crash due to an access of
> an unhandled bond_dev->ml_priv pointer.
> 
> Deny to enslave CAN devices by the bonding driver as the resulting bond_dev
> pretends to be a CAN device by copying dev->type without really being one.

Does the team driver have the same problem?

-- 
Sabrina
