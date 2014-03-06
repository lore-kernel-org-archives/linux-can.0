From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: About timestamping and can-utils
Date: Thu, 06 Mar 2014 10:25:34 +0100
Message-ID: <53183F0E.7050309@peak-system.com>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:33457 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbaCFJZp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Mar 2014 04:25:45 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi linux-can team,

I've got one question about how timestamping is done now in linux-can,=20
regarding to HW timestamps.

In the early ages (~v3.4), the CAN hardware driver could set the=20
timestamp of an skb by itself and push it with the received CAN frame,=20
so that the application could get it using SO_TIMESTAMP socket option,=20
right?
Now, this "hardware" timestamp is to be copied into "hwstamp" field of=20
the "skb_hwtstamps(skb)" area.

But how does user application manage to get this hardware timestamp on=20
its side? AFAIK, the "candump" can-utils utility always reads and=20
displays the "network" timestamp (that is, always uses SO_TIMESTAMP=20
socket option). I had a quick look to the Kernel sources and tried to=20
find the links between things but it's not very clear to me: first idea=
=20
I tested was to set the SO_TIMESTAMPING socket option, but candump neve=
r=20
received any hw timestamp in the control messages he reads from the CAN=
=20
socket...

Any help would be appreciated.

Regards,

St=E9phane
--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
