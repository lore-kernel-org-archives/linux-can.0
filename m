From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH] peak_pci: fix use after free in netdev teardown
Date: Mon, 19 May 2014 11:14:47 +0200
Message-ID: <5379CB87.20106@peak-system.com>
References: <1397072720.22713.19.camel@acrs-z800-1>
 <5379AE8C.9050406@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:36030 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841AbaESJOz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 19 May 2014 05:14:55 -0400
In-Reply-To: <5379AE8C.9050406@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "Christopher R. Baker" <cbaker@rec.ri.cmu.edu>, linux-can@vger.kernel.org

Hi All,

So I finally had a look to the diff file. It clearly does what=20
Christopher says, that is, it fixes some memory access order issues whe=
n=20
the CAN devices have to be removed from the system, either when probing=
=20
has failed or when the driver is unloaded from the system.

The diff file has to be re-written into a Linux-coding style patch, and=
=20
yes, maybe all this removing stuff could be put into a (new) single=20
function made for that.

So, how do we proceed, please ?

Regards,

St=C3=A9phane

Le 19/05/2014 09:11, Marc Kleine-Budde a =C3=A9crit :
> On 04/09/2014 09:45 PM, Christopher R. Baker wrote:
>> Hi All,
>>
>> In the course of tracking down (and eventually backporting) a fix to=
 one
>> of my systems that is still running a 3.2 kernel, I noticed what I
>> believe to be a pair of use-after-free bugs in peak_pci.c pertaining=
 to
>> the linked list of netdevs that is maintained for multi-port cards.
>> These bugs persist in 3.14, so I thought I should send along a patch=
 for
>> review.
>>
>> Basically, the "prev_dev" pointer that is used for this list lives i=
n
>> memory that is allocated by alloc_sja1000dev(), but it is referenced
>> after the call to free_sja1000dev() when walking the list during
>> teardown, both in the failure case of peak_pci_probe and in
>> peak_pci_remove.  Unless I'm missing something, these are toes waiti=
ng
>> to be stubbed...
>>
>> Caveats:
>>   - This is a growing blob of copy-pasta that should probably be
>> refactored to a common location.  For example, peak_pci_remove could=
 be
>> restructured to incrementally check and free allocated resources,
>> allowing the "failure_remove_channels" label to delegate the cleanup=
 to
>> peak_pci_remove.  I didn't want to bite off too much this time, thou=
gh,
>> so I left that alone.
>>   - I don't have an expresscard adapter to check the placement of th=
e
>> pciec_remove stanzas.  By inspection, unregister_sja1000dev does not
>> appear to have a path back to the pciec stuff, but I may have missed
>> something.
>>
>> -ChrisR
>>
>> Signed-of-by: Christopher R. Baker <cbaker@rec.ri.cmu.edu>
> Stephane, can you please have a look at the patch.
>
> Marc
>

--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
--
