From: "Enrico Weigelt, metux IT consult" <weigelt@melag.de>
Subject: Re: slcand in init.d-scripts
Date: Mon, 8 Jun 2015 14:16:35 +0200
Message-ID: <557587A3.6050209@melag.de>
References: <20150608101412.Horde.cpWZ5_FJEM-ciNcxvoY5Nkf@webmail.uni-bremen.de> <55757150.7020008@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.melag.de ([217.6.74.107]:64218 "EHLO mail.melag.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752601AbbFHMQl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 8 Jun 2015 08:16:41 -0400
In-Reply-To: <55757150.7020008@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Armin Burchardt <armin@uni-bremen.de>, linux-can@vger.kernel.org

Am 08.06.2015 um 12:41 schrieb Oliver Hartkopp:

Hi,

<snip>

maybe you could also add an compile-time option to opt-out from
this code, so we can save a few bits in embedded environments
if we dont need it.

I, personally, prefer starting such services via some service
monitor (sometimes even an simply inittab entry is enought).


cu
--
Enrico Weigelt, metux IT consult
+49-151-27565287
MELAG Medizintechnik oHG Sitz Berlin Registergericht AG Charlottenburg =
HRA 21333 B

Wichtiger Hinweis: Diese Nachricht kann vertrauliche oder nur f=C3=BCr =
einen begrenzten Personenkreis bestimmte Informationen enthalten. Sie i=
st ausschlie=C3=9Flich f=C3=BCr denjenigen bestimmt, an den sie gericht=
et worden ist. Wenn Sie nicht der Adressat dieser E-Mail sind, d=C3=BCr=
fen Sie diese nicht kopieren, weiterleiten, weitergeben oder sie ganz o=
der teilweise in irgendeiner Weise nutzen. Sollten Sie diese E-Mail irr=
t=C3=BCmlich erhalten haben, so benachrichtigen Sie bitte den Absender,=
 indem Sie auf diese Nachricht antworten. Bitte l=C3=B6schen Sie in die=
sem Fall diese Nachricht und alle Anh=C3=A4nge, ohne eine Kopie zu beha=
lten.
Important Notice: This message may contain confidential or privileged i=
nformation. It is intended only for the person it was addressed to. If =
you are not the intended recipient of this email you may not copy, forw=
ard, disclose or otherwise use it or any part of it in any form whatsoe=
ver. If you received this email in error please notify the sender by re=
plying and delete this message and any attachments without retaining a =
copy.
