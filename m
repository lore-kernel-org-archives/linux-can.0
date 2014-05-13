From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 0/2] CAN SJA100 controller emulation and
 SocketCAN based host CAN bus access
Date: Tue, 13 May 2014 14:29:08 +0200
Message-ID: <CAJSP0QXLCZYrvHpPQH6CSTkfL2ezdvZya32kuHfs4FgYvC_Btg@mail.gmail.com>
References: <201405092010.19482.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <201405092010.19482.pisa@cmp.felk.cvut.cz>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: Oliver Hartkopp A <socketcan@hartkopp.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, jinyang.sia@gmail.com, rtems-devel@rtems.org, Stefan Weil <sw@weilnetz.de>, linux-can@vger.kernel.org, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
List-Id: linux-can.vger.kernel.org

On Fri, May 9, 2014 at 8:10 PM, Pavel Pisa <pisa@cmp.felk.cvut.cz> wrote:

Please run the patches through scripts/checkpatch.pl and address the warnings.

This patch doesn't use QEMU's network layer.  Perhaps it should but
I'm not familiar with CAN.  The QEMU network layer implements a
point-to-point model where NetClientState instances can send/receive
packets.  It seems a subset of this was reimplemented for CAN but I
don't see much unique behavior in the core CAN code.  Why didn't you
use the QEMU network layer?

>   - CAN bus simple SJA1000 PCI card emulation for QEMU
>
>     Files:
>
>       - include/net/can_emu.h
>           - basic CAN bus related types. Those which could possibly clash
>             with Linux kernel prepended by "qemu_".
>           - prototypes for CAN buses naming and clients registration
>           - original Jin Yang approach uses chardev, but that does not
>             map well to little different semantics of CAN messages
>             distribution. I have considered common vlan code but
>             I have not found how to use it with CAN well too.
>
>       - hw/net/can_core.c
>           - implementation of CAN messages delivery
>           - support to connect into real host CAN bus network for case
>             of Linux SocketCAN

The network layer implements (poorly) a flow control mechanism so that
devices with limited buffers, like a USB network card, can pause
receive until the guest has drained the receive buffer.  I don't see
that in the CAN code, so is it okay to drop frames?

About the Linux socket file descriptor:
1. It should be non-blocking because QEMU is an event-driven program.
We must never block waiting to read/write data from/to a socket.
2. Missing EINTR error handling in case a signal interrupted a
read(2)/write(2) system call.

In the QEMU network layer the can_core.c behavior would be produced
using a hub with a tap or socket netdev.  The broadcast code in the
hub netdev is separate from the Linux-specific tap code.  I think you
can implement a CAN socket netdev and use the hub to broadcast.

>       - hw/net/can_sja1000.h
>           - declarations of SJA1000 CAN controller registers
>             and connection type independent part of API
>
>       - hw/net/can_sja1000.c
>           - SJA1000 CAN controller registers and registers model
>             implementation - hard part implemented by Jin Yang
>
>       - hw/net/can_pci.c
>           - connection of above infrastructure to the minimal PCI
>             card with only one mmio BAR and no bridge interrupts setup
>             and control. Unfortuantelly, I am not aware of any such
>             straightforward card but it is great for testing and
>             drivers porting. Used vendor and product ID are random ones
>             chosen by Jin Yang, if there is some consensus that work worth
>             for integration then I suggest to ask RedHat for unique PCI ID
>             donation

What is the relationship between can_pci.c and the emulated Kvaser device?

Implementing one real device would be very important to establish that
this CAN implementation can model real devices.

Stefan
