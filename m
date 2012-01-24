From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [Socketcan-users] increase buffer size
Date: Tue, 24 Jan 2012 18:55:40 +0100
Message-ID: <4F1EF09C.8050206@hartkopp.net>
References: <16594621.klnj3Hkir3@lisa> <2F0BDF8C-F6D0-4CCD-A08D-3D969B98BB02@t-online.de> <5532811.lHVu6H1glq@lisa>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:37347 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888Ab2AXRzq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Jan 2012 12:55:46 -0500
In-Reply-To: <5532811.lHVu6H1glq@lisa>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Steffen Rose <ro@emtas.de>
Cc: linux-can@vger.kernel.org

On 24.01.2012 17:50, Steffen Rose wrote:

> Am Dienstag, 24. Januar 2012, 17:31:56 schrieb Heinz-Juergen Oertel:
>> Von meinem iPhone gesendet
>>
>> Am 24.01.2012 um 16:36 schrieb Steffen Rose <ro@emtas.de>:
>>> Du liest sicher mit...
>>
>> Ja, werde trotzdem nicht schlau wer die  Puffer, bes. RX verwaltet.
>=20
> Wenn Du mich fragts:
>=20
> RX Buffer: Hier wird die Socket Quere genutzt.


Yes. When a CAN frame is received the frame is delivered to the per-soc=
ket
receive queue due to the socket specific selected filter (default: rece=
ive
everything from the given CAN netdevice). See can.txt

http://lxr.linux.no/#linux+v3.2.1/Documentation/networking/can.txt#L245

and for the filters:

http://lxr.linux.no/#linux+v3.2.1/Documentation/networking/can.txt#L377

You can play with the filters using 'candump' that allows to set up mul=
tiple
filters.

> TX Buffer: Hierf=C3=BCr ist der CAN Treiber verantwortlich. Die Socke=
t Quere k=C3=B6nnte=20
> genutzt werden, wird aber typ. nicht genutzt.


Writing to a CAN_RAW socket leads directly to the can_send() function t=
hat
put's the CAN frame to the CAN netdevice specific tx queue.

See:

http://lxr.linux.no/#linux+v3.2.1/net/can/raw.c#L640

http://lxr.linux.no/#linux+v3.2.1/net/can/raw.c#L690

If there's space in the queue it is stored into the FIFO.
If the tx queue is full, you directly get an error for the write() or
send[msg]() system call.

http://lxr.linux.no/#linux+v3.2.1/net/can/af_can.c#L209

Regards,
Oliver
