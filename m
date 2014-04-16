From: Stanislav Meduna <stano@meduna.org>
Subject: FlexCAN i.MX28 BUG! hardware recovered automatically from BUS_OFF
Date: Wed, 16 Apr 2014 13:52:43 +0200
Message-ID: <534E6F0B.70100@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:42588 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755604AbaDPLww (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 16 Apr 2014 07:52:52 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: wg@grandegger.com, Marc Kleine-Budde <mkl@pengutronix.de>

On 07.03.2014 09:08, Stanislav Meduna wrote:
Hi,

I am using a FlexCAN CAN controller on a Freescale i.MX28
platform [1] and I am upgrading from kernel 3.4 to 3.12.15-rt25.
I am testing the behaviour regarding bus errors, so I run
a test program where the can1 sends and can0 receives and
I am trying to induce bus problems.

If there is no ip link set ... restart-ms parametrized,
the bus does not recover from being left unconnected for
a while

# ip -d -s link show can1
3: can1: <NO-CARRIER,NOARP,UP,ECHO> mtu 16 qdisc pfifo_fast state DOWN qlen 10
    link/can
    can state BUS-OFF (berr-counter tx 0 rx 0) restart-ms 0
    bitrate 500000 sample-point 0.875
    tq 125 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
    flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 brp-inc 1
    clock 24000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          7          3          2
    RX: bytes  packets  errors  dropped overrun mcast
    320        130      0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    117        59       0       1       0       0

If I configure restart-ms 100, the controller recovers

3: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UP qlen 10
    link/can
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 100
    bitrate 500000 sample-point 0.875
    tq 125 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
    flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 brp-inc 1
    clock 24000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    20         0          0          27         23         22
    RX: bytes  packets  errors  dropped overrun mcast
    960        210      0       0       0       0
    TX: bytes  packets  errors  dropped carrier collsns
    147        73       0       22      0       0

but while disconnected it floods the log with

[ 1866.452038] flexcan 80034000.can can1: writing ctrl=0x0231a055
[ 1867.447723] flexcan 80034000.can can1: BUG! hardware recovered automatically from BUS_OFF
[ 1867.456128] flexcan 80034000.can can1: writing ctrl=0x0231a055
[ 1868.447649] flexcan 80034000.can can1: BUG! hardware recovered automatically from BUS_OFF

Is this the expected behaviour? What exactly is the "BUG"?

Please Cc: me when replying.

[1] http://www.tq-group.com/en/products/product-details/prod/embedded-modul-tqma28/extb/Main/productdetail/

Thanks
-- 
                                              Stano

