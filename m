From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v3] can, slip: Protect tty->disc_data in write_wakeup
 and close with RCU
Date: Wed, 22 Jan 2020 20:32:52 +0100 (CET)
Message-ID: <20200122.203252.1974816529601154217.davem@davemloft.net>
References: <20200121134258.18013-1-rpalethorpe@suse.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200121134258.18013-1-rpalethorpe@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rpalethorpe@suse.com
Cc: linux-can@vger.kernel.org, syzbot+017e491ae13c0068598a@syzkaller.appspotmail.com, wg@grandegger.com, mkl@pengutronix.de, tylerwhall@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
List-Id: linux-can.vger.kernel.org

From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 21 Jan 2020 14:42:58 +0100

> write_wakeup can happen in parallel with close/hangup where tty->disc_data
> is set to NULL and the netdevice is freed thus also freeing
> disc_data. write_wakeup accesses disc_data so we must prevent close from
> freeing the netdev while write_wakeup has a non-NULL view of
> tty->disc_data.
> 
> We also need to make sure that accesses to disc_data are atomic. Which can
> all be done with RCU.
> 
> This problem was found by Syzkaller on SLCAN, but the same issue is
> reproducible with the SLIP line discipline using an LTP test based on the
> Syzkaller reproducer.
> 
> A fix which didn't use RCU was posted by Hillf Danton.
> 
> Fixes: 661f7fda21b1 ("slip: Fix deadlock in write_wakeup")
> Fixes: a8e83b17536a ("slcan: Port write_wakeup deadlock fix from slip")
> Reported-by: syzbot+017e491ae13c0068598a@syzkaller.appspotmail.com
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>

Applied and queued up for -stable, thanks.
