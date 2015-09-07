From: Pavel Pisa <pisa-/N2ztlQkxE7Ub/6JBqosbQ@public.gmane.org>
Subject: PCI CAN interface emulation updated for QEMU 2.4
Date: Tue, 8 Sep 2015 01:51:38 +0200
Message-ID: <201509080151.38392.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces-WKV1R6NGPIzYtjvyW6yDsg@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.rtems.org/mailman/options/devel>,
 <mailto:devel-request-WKV1R6NGPIzYtjvyW6yDsg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.rtems.org/pipermail/devel/>
List-Post: <mailto:devel-WKV1R6NGPIzYtjvyW6yDsg@public.gmane.org>
List-Help: <mailto:devel-request-WKV1R6NGPIzYtjvyW6yDsg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.rtems.org/mailman/listinfo/devel>,
 <mailto:devel-request-WKV1R6NGPIzYtjvyW6yDsg@public.gmane.org?subject=subscribe>
Errors-To: devel-bounces-WKV1R6NGPIzYtjvyW6yDsg@public.gmane.org
Sender: "devel" <devel-bounces-WKV1R6NGPIzYtjvyW6yDsg@public.gmane.org>
To: devel-WKV1R6NGPIzYtjvyW6yDsg@public.gmane.org
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oliver Hartkopp <oliver.hartkopp-l29pVbxQd1IUtdQbppsyvg@public.gmane.org>, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org
List-Id: linux-can.vger.kernel.org

Hello everybody,

the project implements simple CAN SJA1000 interface emulation
with option to connect emulated CAN buses to host system
SocketCAN bus. Project has been started by Jin Yang in frame
of RTEMS provided GSoC 2013 slot.

Code has been cleaned and is maintained to be up-to
date with actual QEMU releases. I would be happy to
follow suggestions and review for its possible
mainlining if there is interrest. If preferred,
I send patches inline to QEMU list.

Code is available from

https://github.com/CTU-IIG/qemu/tree/can-pci

The "can-pci" branch has been updated for QEMU-2.4 now.
The previous 2.3 support moved on "can-pci-2.3" branch.
Older support and support for PCI MF624 data acquisition
card can be found on merged branches merged-2.1,
merged-2.3 and merged-2.4.

https://github.com/CTU-IIG/qemu

Documentation

https://rtime.felk.cvut.cz/can/can-qemu/
https://devel.rtems.org/wiki/Developer/Simulators/QEMU/CANEmulation

Relevant commits

commit 2d873a9ed3bcb8301a247f36b77227b1cd9211c0
Author: Pavel Pisa <pisa-/N2ztlQkxE7Ub/6JBqosbQ@public.gmane.org>
Date:   Mon Sep 7 15:24:56 2015 +0200

    CAN bus simple SJA1000 PCI card emulation for QEMU

    The work is based on Jin Yang GSoC 2013 work funded
    by Google and mentored in frame of RTEMS project GSoC
    slot donated to QEMU.

    Rewritten for QEMU-2.0+ versions and architecture cleanup
    by Pavel Pisa (Czech Technical University in Prague).

    The core SJA1000 support is independent of provided
    PCI board. The simple core CAN bus infrastructure
    is independent as well.

    Connection to the real host CAN bus network through
    SocketCAN network interface is available for Linux
    host system as well.

    Signed-off-by: Pavel Pisa <pisa-/N2ztlQkxE7Ub/6JBqosbQ@public.gmane.org>

commit 3eda61e54b947f1508a05f8b67277dd717a8c963
Author: Pavel Pisa <pisa-/N2ztlQkxE7Ub/6JBqosbQ@public.gmane.org>
Date:   Mon Sep 7 15:27:08 2015 +0200

    CAN bus Kvaser PCI CAN-S (single SJA1000 channel) emulation added.

    Signed-off-by: Pavel Pisa <pisa-/N2ztlQkxE7Ub/6JBqosbQ@public.gmane.org>


Best wishes,

             Pavel Pisa
