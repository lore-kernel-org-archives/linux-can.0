From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: CAN-BCM periodic send signaling
Date: Tue, 07 Jan 2014 10:47:53 +0100
Message-ID: <52CBCD49.9070100@hartkopp.net>
References: <003601cf0b02$53c58f10$fb50ad30$@annecy-elec.fr> <52CAF12B.1000006@hartkopp.net> <000001cf0b82$9577bca0$c06735e0$@annecy-elec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:63434 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbaAGJr7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 7 Jan 2014 04:47:59 -0500
In-Reply-To: <000001cf0b82$9577bca0$c06735e0$@annecy-elec.fr>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Boris Baskevitch <boris.baskevitch@annecy-elec.fr>
Cc: linux-can@vger.kernel.org

Hi Boris,

when you update the tx job please make sure that the nframes remains 16=
 and
the entire message to the BCM contains 16 CAN frames.

In your example below you switch back to a tx job with one single CAN f=
rame
(=3D=3D no sequence of 16 frames).

Updating a BCM tx job content is just about copying the CAN frame conte=
nts:
http://lxr.free-electrons.com/source/net/can/bcm.c#L847

When you send only one frame in the updated tx job only this frame is c=
opied
and the new nframes (=3D=3D1) is taken for the job. Bye bye message seq=
uence :-)

http://lxr.free-electrons.com/source/net/can/bcm.c#L847

Regards,
Oliver

On 07.01.2014 09:29, Boris Baskevitch wrote:
> Hi Oliver,
> Thanks for the reply, the counter works well this way.
> But I also need to update the message with real payload in the other =
bytes of the message.
> I placed the counter in the last byte of the message, I setup the per=
iodic message as you described (I extended it to a 4-bit counter, using=
 16 frames).
> Then I use the following function to update the payload without touch=
ing the frame counter.
> This function if called much more frequently than the message period,=
 I don=E2=80=99t use TX_ANNOUNCE in it to make sure the message period =
is stable on the bus.
> Unfortunately, doing this way is corrupting the frame counter: it see=
ms that calling the update function is incrementing the frame pointer o=
f the message.
> Note that when I update the payload, I update only msg.frame[0] and n=
ot the 15 other frames of the message, but on the bus, I can see that a=
ll the frames are updated with my payload. That's why I think the frame=
 pointer is updated each time I call the update function.
> Is there a way to update the payload without touching the frame point=
er ?
>=20
> void UpdatePeriodicSendValues(void)
> {
>      struct {
> 	struct bcm_msg_head msg_head;
> 	struct can_frame frame[1];
>      } msg;
>    =20
>     msg.msg_head.opcode =3D TX_SETUP;
>     msg.msg_head.flags =3D TX_CP_CAN_ID;
>     msg.msg_head.count =3D 0;
>     msg.msg_head.can_id =3D 0x42;
>     msg.msg_head.nframes =3D 1;
>     msg.frame[0].can_dlc =3D 8;
>=20
>     msg.frame[0].data[0] =3D MyData1 ;
>     msg.frame[0].data[1] =3D MyData2;
>     msg.frame[0].data[2] =3D 0;
>     msg.frame[0].data[3] =3D 0;
>     msg.frame[0].data[4] =3D 0;
>     msg.frame[0].data[5] =3D 0;
>     msg.frame[0].data[6] =3D 0;
>     //msg.frame[0].data[7] =3D this is the frame counter, don't touch=
 it !
>=20
>     write(m_fd, &msg, sizeof(msg));
>=20
>     return;
> }
>=20
>=20
>=20
> Boris
>=20
>=20
>=20
>> -----Message d'origine-----
>> De : Oliver Hartkopp [mailto:socketcan@hartkopp.net]
>> Envoy=C3=A9 : lundi 6 janvier 2014 19:09
>> =C3=80 : Boris Baskevitch
>> Cc : linux-can@vger.kernel.org
>> Objet : Re: CAN-BCM periodic send signaling
>>
>> Hey Boris,
>>
>> On 06.01.2014 18:11, Boris Baskevitch wrote:
>>
>>> I'm using the CAN-BCM to send periodic CAN messages on the bus.
>>> In one of those messages, I need to send a counter value which is
>> incremented each time the message is sent.
>>> How can I do that ?
>>
>> E.g. if you have a 4 bit counter, you just send 16 "struct can_frame=
s" at
>> TX_SETUP time - also set nframes to 16 then.
>>
>> When nframes > 1 a sequence of CAN frames is sent automatically.
>> You may alter these CAN frames at runtime.
>> If you do so, the tx index may be set to "0" (start) with TX_RESET_M=
ULTI_IDX.
>>
>> See tst-bcm-cycle.c from the git://gitorious.org/linux-can/can-tests=
=2Egit
>>
>> Here's the patch to demonstrate it based on can-tests repository wit=
h
>> nframes=3D4:
>>
>> diff --git a/tst-bcm-cycle.c b/tst-bcm-cycle.c
>> index b85ceed..adb2fd6 100644
>> --- a/tst-bcm-cycle.c
>> +++ b/tst-bcm-cycle.c
>> @@ -89,16 +89,29 @@ int main(int argc, char **argv)
>>
>>  	msg.msg_head.opcode  =3D TX_SETUP;
>>  	msg.msg_head.can_id  =3D 0x42;
>> -	msg.msg_head.flags   =3D SETTIMER|STARTTIMER;
>> -	msg.msg_head.nframes =3D 1;
>> -	msg.msg_head.count =3D 10;
>> -	msg.msg_head.ival1.tv_sec =3D 1;
>> +	msg.msg_head.flags   =3D SETTIMER|STARTTIMER|TX_CP_CAN_ID;
>> +	msg.msg_head.nframes =3D 4;
>> +	msg.msg_head.count =3D 0;
>> +	msg.msg_head.ival1.tv_sec =3D 0;
>>  	msg.msg_head.ival1.tv_usec =3D 0;
>>  	msg.msg_head.ival2.tv_sec =3D 0;
>> -	msg.msg_head.ival2.tv_usec =3D 0;
>> -	msg.frame[0].can_id    =3D 0x42;
>> +	msg.msg_head.ival2.tv_usec =3D 200000;
>> +
>> +	//msg.frame[0].can_id    =3D 0x42; /* obsolete due to TX_CP_CAN_ID=
 */
>>  	msg.frame[0].can_dlc   =3D 8;
>> -	U64_DATA(&msg.frame[0]) =3D (__u64) 0xdeadbeefdeadbeefULL;
>> +	U64_DATA(&msg.frame[0]) =3D (__u64) 0x01000000deadbeefULL;
>> +
>> +	//msg.frame[1].can_id    =3D 0x42; /* obsolete due to TX_CP_CAN_ID=
 */
>> +	msg.frame[1].can_dlc   =3D 8;
>> +	U64_DATA(&msg.frame[1]) =3D (__u64) 0x02000000deadbeefULL;
>> +
>> +	//msg.frame[2].can_id    =3D 0x42; /* obsolete due to TX_CP_CAN_ID=
 */
>> +	msg.frame[2].can_dlc   =3D 8;
>> +	U64_DATA(&msg.frame[2]) =3D (__u64) 0x03000000deadbeefULL;
>> +
>> +	//msg.frame[3].can_id    =3D 0x42; /* obsolete due to TX_CP_CAN_ID=
 */
>> +	msg.frame[3].can_dlc   =3D 8;
>> +	U64_DATA(&msg.frame[3]) =3D (__u64) 0x04000000deadbeefULL;
>>
>>  	if (write(s, &msg, sizeof(msg)) < 0)
>>  		perror("write");
>>
>> Does this fit your needs?
>>
>> Regards,
>> Oliver
>=20
>=20
