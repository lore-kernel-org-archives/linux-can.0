From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: hi311x: Acquire SPI lock on ->do_get_berr_counter
Date: Thu, 10 May 2018 18:23:37 +0200
Message-ID: <5fef7d7f-77d4-e2c9-3f55-bd2ae48b0f83@pengutronix.de>
References: <b1518690dd293a008959b56cc52f3f29f52be25e.1525869191.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <b1518690dd293a008959b56cc52f3f29f52be25e.1525869191.git.lukas@wunner.de>
Content-Language: de-DE
Sender: netdev-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org
Cc: Mathias Duckeck <m.duckeck@kunbus.de>, Akshay Bhat <akshay.bhat@timesys.com>, Casey Fitzpatrick <casey.fitzpatrick@timesys.com>, Stef Walter <stefw@redhat.com>, Karel Zak <kzak@redhat.com>
List-Id: linux-can.vger.kernel.org

On 05/09/2018 02:38 PM, Lukas Wunner wrote:
> hi3110_get_berr_counter() may run concurrently to the rest of the driver
> but neglects to acquire the lock protecting access to the SPI device.
> As a result, it and the rest of the driver may clobber each other's tx
> and rx buffers.
> 
> We became aware of this issue because transmission of packets with
> "cangen -g 0 -i -x" frequently hung.  It turns out that agetty executes
> ->do_get_berr_counter every few seconds via the following call stack:
> 
>     CPU: 2 PID: 1605 Comm: agetty
>     [<7f3f7500>] (hi3110_get_berr_counter [hi311x])
>     [<7f130204>] (can_fill_info [can_dev])
>     [<80693bc0>] (rtnl_fill_ifinfo)
>     [<806949ec>] (rtnl_dump_ifinfo)
>     [<806b4834>] (netlink_dump)
>     [<806b4bc8>] (netlink_recvmsg)
>     [<8065f180>] (sock_recvmsg)
>     [<80660f90>] (___sys_recvmsg)
>     [<80661e7c>] (__sys_recvmsg)
>     [<80661ec0>] (SyS_recvmsg)
>     [<80108b20>] (ret_fast_syscall+0x0/0x1c)
> 
> agetty listens to netlink messages in order to update the login prompt
> when IP addresses change (if /etc/issue contains \4 or \6 escape codes):
> https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/commit/?id=e36deb6424e8
> 
> It's a useful feature, though it seems questionable that it causes CAN
> bit error statistics to be queried.
> 
> Be that as it may, if hi3110_get_berr_counter() is invoked while a frame
> is sent by hi3110_hw_tx(), bogus SPI transfers like the following may
> occur:
> 
>     => 12 00             (hi3110_get_berr_counter() wanted to transmit
>                           EC 00 to query the transmit error counter,
>                           but the first byte was overwritten by
>                           hi3110_hw_tx_frame())
> 
>     => EA 00 3E 80 01 FB (hi3110_hw_tx_frame() wanted to transmit a
>                           frame, but the first byte was overwritten by
>                           hi3110_get_berr_counter() because it wanted
>                           to query the receive error counter)
> 
> This sequence hangs the transmission because the driver believes it has
> sent a frame and waits for the interrupt signaling completion, but in
> reality the chip has never sent away the frame since the commands it
> received were malformed.
> 
> Fix by acquiring the SPI lock in hi3110_get_berr_counter().
> 
> I've scrutinized the entire driver for further unlocked SPI accesses but
> found no others.
> 
> Cc: Mathias Duckeck <m.duckeck@kunbus.de>
> Cc: Akshay Bhat <akshay.bhat@timesys.com>
> Cc: Casey Fitzpatrick <casey.fitzpatrick@timesys.com>
> Cc: Stef Walter <stefw@redhat.com>
> Cc: Karel Zak <kzak@redhat.com>
> Cc: stable@vger.kernel.org # v4.12+
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Applied to can.

Tnx,
Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
