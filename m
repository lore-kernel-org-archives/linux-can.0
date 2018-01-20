From: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Subject: Re: [PATCH V2 0/3] Microchip mcp25xxfd can controller driver
Date: Sat, 20 Jan 2018 09:44:01 +0100
Message-ID: <11b290bb586b37cde79599293a5ef0f4@gerhard-bertelsmann.de>
References: <20180119074140.25931-1-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.rdts.de ([195.243.153.28]:38470 "EHLO mail.rdts.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751055AbeATIw0 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sat, 20 Jan 2018 03:52:26 -0500
In-Reply-To: <20180119074140.25931-1-kernel@martin.sperl.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Linux Can <linux-can@vger.kernel.org>, Wolfgang Grandegger <wg@grandegger.com>, Mark Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@martin.sperl.org

Hi,

many thanks Martin for the update. The code works flawlesly here
in a mixed environment with a manual setup of the timing parameters.
I had to setup the timing by hand to get it working with all my CAN
bus members (250kb):

ip link set can0 up type can tq 250 prop-seg 6 phase-seg1 7 phase-seg2 2 
sjw 1

I need to do this because the kernel CAN bit timing calculation has
imho a problem with wide range timing parameters. Here the calculation
based on the Kernel algorithm (used an extended can-calc-bit-timnig):

Bit timing parameters for mcp2517fd with 40.000000 MHz ref clock
nominal                                 real Bitrt   nom  real SampP
Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP Bitrate Error SampP SampP Error 
CiNBTCFG
1000000     25  14   15   10   1   1 1000000  0.0% 75.0% 75.0%  0.0% 
0x001c0900
  800000     25  19   20   10   1   1  800000  0.0% 80.0% 80.0%  0.0% 
0x00260900
  500000     25  34   35   10   1   1  500000  0.0% 87.5% 87.5%  0.0% 
0x00440900
  250000     25  69   70   20   1   1  250000  0.0% 87.5% 87.5%  0.0% 
0x008a1300
  125000     50  69   70   20   1   2  125000  0.0% 87.5% 87.5%  0.0% 
0x018a1300
  100000     50  87   87   25   1   2  100000  0.0% 87.5% 87.5%  0.0% 
0x01ad1800
   50000    100  87   87   25   1   4   50000  0.0% 87.5% 87.5%  0.0% 
0x03ad1800
   20000    250  87   87   25   1  10   20000  0.0% 87.5% 87.5%  0.0% 
0x09ad1800
   10000    500  87   87   25   1  20   10000  0.0% 87.5% 87.5%  0.0% 
0x13ad1800

The kernel algorithm try to use the smallest SYNC_SEG (-> SJW) to
calculate the other values. But a tq of 25 ns seems to be to small
for the synchonization segment on a mixed 50kb environment.
I've read a bunch of different CAN bit timing docs and they are talking
about 16 or 20 time quantas.

Anyway the mcp25xxfd kernel module works:

Tested-by: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>



