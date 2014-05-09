From: Pavel Pisa <pisa-/N2ztlQkxE7Ub/6JBqosbQ@public.gmane.org>
Subject: [PATCH 0/2] CAN SJA100 controller emulation and SocketCAN based host
 CAN bus access
Date: Fri, 9 May 2014 20:10:19 +0200
Message-ID: <201405092010.19482.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <rtems-devel-bounces-WKV1R6NGPIzYtjvyW6yDsg@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://www.rtems.org/mailman/options/rtems-devel>,
 <mailto:rtems-devel-request-WKV1R6NGPIzYtjvyW6yDsg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://www.rtems.org/pipermail/rtems-devel/>
List-Post: <mailto:rtems-devel-WKV1R6NGPIzYtjvyW6yDsg@public.gmane.org>
List-Help: <mailto:rtems-devel-request-WKV1R6NGPIzYtjvyW6yDsg@public.gmane.org?subject=help>
List-Subscribe: <http://www.rtems.org/mailman/listinfo/rtems-devel>,
 <mailto:rtems-devel-request-WKV1R6NGPIzYtjvyW6yDsg@public.gmane.org?subject=subscribe>
Errors-To: rtems-devel-bounces-WKV1R6NGPIzYtjvyW6yDsg@public.gmane.org
Sender: rtems-devel-bounces-WKV1R6NGPIzYtjvyW6yDsg@public.gmane.org
To: "qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org" <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, Oliver Hartkopp A <socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>, jinyang.sia-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Stefan Weil <sw-QDXxdeohBKYb1SvskN2V4Q@public.gmane.org>, rtems-devel-WKV1R6NGPIzYtjvyW6yDsg@public.gmane.org, Andreas =?iso-8859-1?q?F=E4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-can.vger.kernel.org

Hello everybody,

I have invested some time to wrap-up and get back
on the track 2013 GSoC Jin Yang work on QEMU CAN
bus emulation done in frame of RTEMS project preparation
for future RTEMS CAN bus infrastructure preparation.

I think that code is important for much wider community.

RTEMS page for original QEMU 1.4 work

  http://www.rtems.org/wiki/index.php/Qemu_simulations

Be warned, page is not yet updated for redesigned CAN
infrastructure conecept

The patch series consists of

  - CAN bus simple SJA1000 PCI card emulation for QEMU

    Files:

      - include/net/can_emu.h
          - basic CAN bus related types. Those which could possibly clash
            with Linux kernel prepended by "qemu_".
          - prototypes for CAN buses naming and clients registration
          - original Jin Yang approach uses chardev, but that does not
            map well to little different semantics of CAN messages
            distribution. I have considered common vlan code but
            I have not found how to use it with CAN well too.

      - hw/net/can_core.c
          - implementation of CAN messages delivery
          - support to connect into real host CAN bus network for case
            of Linux SocketCAN

      - hw/net/can_sja1000.h
          - declarations of SJA1000 CAN controller registers
            and connection type independent part of API

      - hw/net/can_sja1000.c
          - SJA1000 CAN controller registers and registers model
            implementation - hard part implemented by Jin Yang

      - hw/net/can_pci.c
          - connection of above infrastructure to the minimal PCI
            card with only one mmio BAR and no bridge interrupts setup
            and control. Unfortuantelly, I am not aware of any such
            straightforward card but it is great for testing and
            drivers porting. Used vendor and product ID are random ones
            chosen by Jin Yang, if there is some consensus that work worth
            for integration then I suggest to ask RedHat for unique PCI ID
            donation

  - CAN bus Kvaser PCI CAN-S (single SJA1000 channel)

    Files:
      - hw/net/can_kvaser_pci.c
            Implementation of 


Testing:

I have implemented first simple single SJA1000 memory mapped PCI
board support for LinCAN

Setup real or virtual can in host system

  modprobe can-raw 
  modprobe vcan
  ip link add dev can0 type vcan
  ip link set can0 up

QEMU run with some subset of next parameters

  $QEMU -enable-kvm -kernel /boot/vmlinuz-3.2.0-4-amd64 \
      -initrd ramdisk.cpio \
      -virtfs local,path=shareddir,security_model=none,mount_tag=shareddir \
      -vga cirrus \
      -device can_pci,model=SJA1000,canbus=canbus0,host=can0 \
      -nographic -append "console=ttyS0"

Run in the guest system

  modprobe lincan hw=pcisja1000mm io=0
  mdev -s

  sendburst
  readburst

Test with Kvaser

  $QEMU -enable-kvm -kernel /boot/vmlinuz-3.2.0-4-amd64 \
      -initrd ramdisk.cpio \
      -virtfs local,path=shareddir,security_model=none,mount_tag=shareddir \
      -vga cirrus \
      -device kvaser_pci,canbus=canbus0,host=can0 \
      -nographic -append "console=ttyS0"

Run in the guest system

  modprobe lincan hw=pcican-s io=0
  mdev -s

SocketCAN in the guest system

No load lincan or rmmod lincan
Then SocketCAN in inner system setup

  modprobe can-raw
  modprobe kvaser-pci
  ip link set can0 type can bitrate 1000000
  ip link set can0 up

  cangen can0 -e -I 123 -g 1000 -D 11223344DEADBEEF -L 8
  candump can0

Visualization in host / outer system possible by QCANalyzer
for example
  
  http://ortcan.sourceforge.net/qcanalyzer/

Code is really hot and more or less proof of concept
but worked for me stable for some while.

There is no buffering in CAN bus model for now
so messages can be easily lost or overwritten.
No CAN filters are in real use for now.
Some filters union and application to the SocketCAN
can be usesfull for future. But separation of CAN
bus model out of chardev and or vlan allows to
implement CAN specific things more easily.

Best wishes,

                Pavel
--
                Pavel Pisa
    e-mail:     pisa-/N2ztlQkxE7Ub/6JBqosbQ@public.gmane.org
    www:        http://cmp.felk.cvut.cz/~pisa
    university: http://dce.fel.cvut.cz/
    company:    http://www.pikron.com/
