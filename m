From: Tim Hotfilter <thotfilter@osdr.org>
Subject: Problem using Linux CAN
Date: Wed, 22 Jul 2015 12:49:20 +0200
Message-ID: <CD02850D-3BF4-4AE3-B1A3-72E34D09C061@osdr.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from dd20724.kasserver.com ([85.13.140.203]:48649 "EHLO
	dd20724.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932481AbbGVI4o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 22 Jul 2015 04:56:44 -0400
Received: from [192.168.1.114] (capt-portal-intranet.scc.kit.edu [141.3.208.9])
	by dd20724.kasserver.com (Postfix) with ESMTPSA id AA8241A0774
	for <linux-can@vger.kernel.org>; Wed, 22 Jul 2015 10:49:23 +0200 (CEST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,

I am developing a control unit using four CAN Controllers based on the =
Xilinx Zynq 7000. Two CAN Controllers (based on the sja1000) are implem=
ented in the Zynq=E2=80=99s FPGA and two are already integrated. The co=
ntrol unit runs Linux 3.19 with socket can.=20
Under higher CAN busload (30% or more) socket CAN returns Error 105: No=
 buffer space available. The problem is independent from the hardware, =
it occurs on both sja1000 and xilinx can. Restarting the network device=
 by bringing it down and up enables to send again. But since there are =
other ECUs using watchdogs this solution is not suitable.=20
After some kernel debugging it exposes that somehow a transmit interrup=
t gets lost. This results in a stopped tx queue and the transmit buffer=
 overflows.

Is there a possibility to handle with the lost interrupt, like waking u=
p the queue after a short timeout?

Thank you in advance!

Best regards=20
Tim Hotfilter

