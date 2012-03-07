From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: can: usb: PEAK-System Technik PCAN-USB specific part
Date: Wed, 07 Mar 2012 10:05:28 +0100
Message-ID: <4F5724D8.4050005@peak-system.com>
References: <20120306112108.GA4362@elgon.mountain>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:46603 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262Ab2CGJFf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Mar 2012 04:05:35 -0500
In-Reply-To: <20120306112108.GA4362@elgon.mountain>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Same but without the stars around "cpu_to_le32()"... (Sorry for that=20
wrong copy/paste)

> FYI, the original code was:
>
>> >  +	else {
>> } else {
>> >  +		u16 tmp16 =3D (u16 )cpu_to_le32(cf->can_id & CAN_ERR_MASK);
>>                              ^^^^^^^^^^^^^^^^^

Regards,

St=E9phane
--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
