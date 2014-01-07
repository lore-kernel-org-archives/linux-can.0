From: "Boris Baskevitch" <boris.baskevitch@annecy-elec.fr>
Subject: RE: CAN-BCM periodic send signaling
Date: Tue, 7 Jan 2014 14:40:19 +0100
Message-ID: <000901cf0bae$01a417e0$04ec47a0$@annecy-elec.fr>
References: <003601cf0b02$53c58f10$fb50ad30$@annecy-elec.fr> <52CAF12B.1000006@hartkopp.net> <000001cf0b82$9577bca0$c06735e0$@annecy-elec.fr> <52CBCD49.9070100@hartkopp.net> <52CBF0CA.9050706@hartkopp.net> <000801cf0ba7$447b9ef0$cd72dcd0$@annecy-elec.fr> <52CC02E5.8080107@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from riga.magic.fr ([188.130.33.24]:52871 "HELO riga.magic.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751280AbaAGNkV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 7 Jan 2014 08:40:21 -0500
In-Reply-To: <52CC02E5.8080107@hartkopp.net>
Content-Language: fr
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: 'Oliver Hartkopp' <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

" preserve this struct for later use"
That's great !
Why didn't I think about it before ?!

Thank you Oliver.

Boris


> -----Message d'origine-----
> De=A0: linux-can-owner@vger.kernel.org [mailto:linux-can-
> owner@vger.kernel.org] De la part de Oliver Hartkopp
> Envoy=E9=A0: mardi 7 janvier 2014 14:37
> =C0=A0: Boris Baskevitch
> Cc=A0: linux-can@vger.kernel.org
> Objet=A0: Re: CAN-BCM periodic send signaling
>=20
>=20
> On 07.01.2014 13:52, Boris Baskevitch wrote:
>=20
> > You're right, the frame counter is not incremented but it is reset.
> > In my case this results to showing only frame[0] of the bus as the
payload
> > is updated more frequently than the message period.
> > I changed my updating function to let it change the 16 frames of th=
e
> > message, but it's still not working:
> > I see no way to update a message frame without touching one byte (t=
he
last
> > one in my case) of the frame (to keep the frame counter untouched).
> > Reading the bcm.c source code, it uses the following memcopy comman=
d
> which
> > overwrite the whole frame.
> > http://lxr.free-electrons.com/source/net/can/bcm.c#L861
> >
>=20
> Yes it does.
>=20
> Create a struct like this:
>=20
> struct {
> 	struct bcm_msg_head msg_head;
> 	struct can_frame frame[16];
> } msg;
>=20
> Set the can_id, can_dlc in all 16 frames to the same values.
> Set the counter in the last byte according to your wanted sequence.
>=20
> Don't know if this is your correct use-case:
> Put identical content in data[0..6] of all 16 CAN frames.
>=20
> send TX_SETUP with this struct (and preserve this struct for later us=
e).
>=20
> On changes:
> Put identical content in data[0..6] of all 16 CAN frames.
> send TX_SETUP (without timer restart) with this struct.
>=20
> This does not harm your counter value nor the sequence nor the timers=
=2E
>=20
> Regards,
> Oliver
>=20
>=20
> > Boris
> >
> >
> >> -----Message d'origine-----
> >> De : Oliver Hartkopp [mailto:socketcan@hartkopp.net]
> >> Envoy=E9 : mardi 7 janvier 2014 13:19
> >> =C0 : Boris Baskevitch
> >> Cc : linux-can@vger.kernel.org
> >> Objet : Re: CAN-BCM periodic send signaling
> >>
> >>
> >>
> >> On 07.01.2014 10:47, Oliver Hartkopp wrote:
> >>> Hi Boris,
> >>>
> >>> when you update the tx job please make sure that the nframes rema=
ins
> 16
> >> and
> >>> the entire message to the BCM contains 16 CAN frames.
> >>>
> >>> In your example below you switch back to a tx job with one single=
 CAN
> >> frame
> >>> (=3D=3D no sequence of 16 frames).
> >>>
> >>> Updating a BCM tx job content is just about copying the CAN frame
> > contents:
> >>> http://lxr.free-electrons.com/source/net/can/bcm.c#L847
> >>>
> >>> When you send only one frame in the updated tx job only this fram=
e is
> >> copied
> >>> and the new nframes (=3D=3D1) is taken for the job. Bye bye messa=
ge
> sequence
> >> :-)
> >>>
> >>> http://lxr.free-electrons.com/source/net/can/bcm.c#L847
> >>
> >> Typo:
> >> http://lxr.free-electrons.com/source/net/can/bcm.c#L938
> >>
> >>>
> >>> Regards,
> >>> Oliver
> >>>
> >>> On 07.01.2014 09:29, Boris Baskevitch wrote:
> >>>> Hi Oliver,
> >>>> Thanks for the reply, the counter works well this way.
> >>>> But I also need to update the message with real payload in the o=
ther
> > bytes
> >> of the message.
> >>>> I placed the counter in the last byte of the message, I setup th=
e
> > periodic
> >> message as you described (I extended it to a 4-bit counter, using =
16
> > frames).
> >>>> Then I use the following function to update the payload without
> > touching
> >> the frame counter.
> >>>> This function if called much more frequently than the message pe=
riod,
I
> >> don=92t use TX_ANNOUNCE in it to make sure the message period is s=
table
on
> >> the bus.
> >>>> Unfortunately, doing this way is corrupting the frame counter: i=
t
seems
> >> that calling the update function is incrementing the frame pointer=
 of
the
> >> message.
> >>>> Note that when I update the payload, I update only msg.frame[0] =
and
not
> >> the 15 other frames of the message, but on the bus, I can see that=
 all
the
> >> frames are updated with my payload. That's why I think the frame
pointer
> > is
> >> updated each time I call the update function.
> >>>> Is there a way to update the payload without touching the frame
pointer
> > ?
> >>>>
> >>>> void UpdatePeriodicSendValues(void)
> >>>> {
> >>>>      struct {
> >>>> 	struct bcm_msg_head msg_head;
> >>>> 	struct can_frame frame[1];
> >>>>      } msg;
> >>>>
> >>>>     msg.msg_head.opcode =3D TX_SETUP;
> >>>>     msg.msg_head.flags =3D TX_CP_CAN_ID;
> >>>>     msg.msg_head.count =3D 0;
> >>>>     msg.msg_head.can_id =3D 0x42;
> >>>>     msg.msg_head.nframes =3D 1;
> >>>>     msg.frame[0].can_dlc =3D 8;
> >>>>
> >>>>     msg.frame[0].data[0] =3D MyData1 ;
> >>>>     msg.frame[0].data[1] =3D MyData2;
> >>>>     msg.frame[0].data[2] =3D 0;
> >>>>     msg.frame[0].data[3] =3D 0;
> >>>>     msg.frame[0].data[4] =3D 0;
> >>>>     msg.frame[0].data[5] =3D 0;
> >>>>     msg.frame[0].data[6] =3D 0;
> >>>>     //msg.frame[0].data[7] =3D this is the frame counter, don't =
touch
it
> > !
> >>>>
> >>>>     write(m_fd, &msg, sizeof(msg));
> >>>>
> >>>>     return;
> >>>> }
> >>>>
> >>>>
> >>>>
> >>>> Boris
> >>>>
> >>>>
> >>>>
> >>>>> -----Message d'origine-----
> >>>>> De : Oliver Hartkopp [mailto:socketcan@hartkopp.net]
> >>>>> Envoy=E9 : lundi 6 janvier 2014 19:09
> >>>>> =C0 : Boris Baskevitch
> >>>>> Cc : linux-can@vger.kernel.org
> >>>>> Objet : Re: CAN-BCM periodic send signaling
> >>>>>
> >>>>> Hey Boris,
> >>>>>
> >>>>> On 06.01.2014 18:11, Boris Baskevitch wrote:
> >>>>>
> >>>>>> I'm using the CAN-BCM to send periodic CAN messages on the bus=
=2E
> >>>>>> In one of those messages, I need to send a counter value which=
 is
> >>>>> incremented each time the message is sent.
> >>>>>> How can I do that ?
> >>>>>
> >>>>> E.g. if you have a 4 bit counter, you just send 16 "struct
can_frames"
> > at
> >>>>> TX_SETUP time - also set nframes to 16 then.
> >>>>>
> >>>>> When nframes > 1 a sequence of CAN frames is sent automatically=
=2E
> >>>>> You may alter these CAN frames at runtime.
> >>>>> If you do so, the tx index may be set to "0" (start) with
> >> TX_RESET_MULTI_IDX.
> >>>>>
> >>>>> See tst-bcm-cycle.c from the
> > git://gitorious.org/linux-can/can-tests.git
> >>>>>
> >>>>> Here's the patch to demonstrate it based on can-tests repositor=
y
with
> >>>>> nframes=3D4:
> >>>>>
> >>>>> diff --git a/tst-bcm-cycle.c b/tst-bcm-cycle.c
> >>>>> index b85ceed..adb2fd6 100644
> >>>>> --- a/tst-bcm-cycle.c
> >>>>> +++ b/tst-bcm-cycle.c
> >>>>> @@ -89,16 +89,29 @@ int main(int argc, char **argv)
> >>>>>
> >>>>>  	msg.msg_head.opcode  =3D TX_SETUP;
> >>>>>  	msg.msg_head.can_id  =3D 0x42;
> >>>>> -	msg.msg_head.flags   =3D SETTIMER|STARTTIMER;
> >>>>> -	msg.msg_head.nframes =3D 1;
> >>>>> -	msg.msg_head.count =3D 10;
> >>>>> -	msg.msg_head.ival1.tv_sec =3D 1;
> >>>>> +	msg.msg_head.flags   =3D
> SETTIMER|STARTTIMER|TX_CP_CAN_ID;
> >>>>> +	msg.msg_head.nframes =3D 4;
> >>>>> +	msg.msg_head.count =3D 0;
> >>>>> +	msg.msg_head.ival1.tv_sec =3D 0;
> >>>>>  	msg.msg_head.ival1.tv_usec =3D 0;
> >>>>>  	msg.msg_head.ival2.tv_sec =3D 0;
> >>>>> -	msg.msg_head.ival2.tv_usec =3D 0;
> >>>>> -	msg.frame[0].can_id    =3D 0x42;
> >>>>> +	msg.msg_head.ival2.tv_usec =3D 200000;
> >>>>> +
> >>>>> +	//msg.frame[0].can_id    =3D 0x42; /* obsolete due to
> TX_CP_CAN_ID */
> >>>>>  	msg.frame[0].can_dlc   =3D 8;
> >>>>> -	U64_DATA(&msg.frame[0]) =3D (__u64)
> 0xdeadbeefdeadbeefULL;
> >>>>> +	U64_DATA(&msg.frame[0]) =3D (__u64)
> 0x01000000deadbeefULL;
> >>>>> +
> >>>>> +	//msg.frame[1].can_id    =3D 0x42; /* obsolete due to
> TX_CP_CAN_ID */
> >>>>> +	msg.frame[1].can_dlc   =3D 8;
> >>>>> +	U64_DATA(&msg.frame[1]) =3D (__u64)
> 0x02000000deadbeefULL;
> >>>>> +
> >>>>> +	//msg.frame[2].can_id    =3D 0x42; /* obsolete due to
> TX_CP_CAN_ID */
> >>>>> +	msg.frame[2].can_dlc   =3D 8;
> >>>>> +	U64_DATA(&msg.frame[2]) =3D (__u64)
> 0x03000000deadbeefULL;
> >>>>> +
> >>>>> +	//msg.frame[3].can_id    =3D 0x42; /* obsolete due to
> TX_CP_CAN_ID */
> >>>>> +	msg.frame[3].can_dlc   =3D 8;
> >>>>> +	U64_DATA(&msg.frame[3]) =3D (__u64)
> 0x04000000deadbeefULL;
> >>>>>
> >>>>>  	if (write(s, &msg, sizeof(msg)) < 0)
> >>>>>  		perror("write");
> >>>>>
> >>>>> Does this fit your needs?
> >>>>>
> >>>>> Regards,
> >>>>> Oliver
> >>>>
> >>>>
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe linux-c=
an"
in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
> >>>
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

