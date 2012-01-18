From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH 0/3 v2] can/usb: Add PEAK-System PCAN USB adapters driver
Date: Wed, 18 Jan 2012 16:42:43 +0100
Message-ID: <4F16E873.5040004@peak-system.com>
References: <1326468404-19330-1-git-send-email-s.grosjean@peak-system.com> <4F16C66C.8070007@grandegger.com>
Reply-To: s.grosjean@peak-system.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-3d.bbox.fr ([194.158.122.58]:64629 "EHLO mail-3d.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757931Ab2ARPms (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 18 Jan 2012 10:42:48 -0500
In-Reply-To: <4F16C66C.8070007@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

Hi Wolfgang,

Many thanks for your Ack and all the time you spent for this.

St=E9phane

Le 18/01/2012 14:17, Wolfgang Grandegger a =E9crit :
> Hi Stephane,
>
> On 01/13/2012 04:26 PM, Stephane Grosjean wrote:
>> That serie of patches adds the peak_usb driver which handles the PCA=
N-USB
>> and PCAN-USB Pro adapters from PEAK-System (http://www.peak-system.c=
om).
>> These patches are planned for kernel v3.02.00 and above.
>>
>> Stephane Grosjean (3):
>>    can/usb: PEAK-System Technik USB adapters driver core
>>    can/usb: PEAK-System Technik PCAN-USB specific part
>>    can/usb: PEAK-System Technik PCAN-USB Pro specific part
> Looks almost good. Just a few more issues. When addressed, you can ad=
d
> my "Acked-by: Wolfgang Grandegger<wg@grandegger.com>"  to the next
> version of all patches, which should *also* go to the USB Linux and
> netdev mainling list.
>
> Thanks,
>
> Wolfgang.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
