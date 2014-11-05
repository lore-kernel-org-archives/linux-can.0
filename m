From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5 1/2] Add documentation for SPI to CAN driver
Date: Wed, 05 Nov 2014 13:19:19 +0100
Message-ID: <545A15C7.2060505@pengutronix.de>
References: <1406565510-10783-1-git-send-email-sbabic@denx.de> <1406565510-10783-2-git-send-email-sbabic@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="TnUnEv5XXaHOMCm6jjhF2rPuaNhkmsK4o"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40426 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753916AbaKEMTc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 5 Nov 2014 07:19:32 -0500
In-Reply-To: <1406565510-10783-2-git-send-email-sbabic@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stefano Babic <sbabic@denx.de>, linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TnUnEv5XXaHOMCm6jjhF2rPuaNhkmsK4o
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2014 06:38 PM, Stefano Babic wrote:
> Signed-off-by: Stefano Babic <sbabic@denx.de>

Here my review of the protocol documentation. As I'm not a native speaker=
, by
remarks about language and grammar are probably not 100% correct :)

>=20
> ---
>=20
> Changes in v5:
> - drop Patch 2/3, already applied.
>=20
> Changes in v4:
> - added GET_CFG message to query bit timing to the remote controller.
>=20
> Changes in v3:
> - format documentation, check for lines > 80 chars (O. Hartkopp)
> - patch 2/3 already aqpplied to can-next, removed from patchset
>=20
> Changes in v2: None
>=20
>  Documentation/networking/spi_can.txt | 774 +++++++++++++++++++++++++++=
++++++++
>  1 file changed, 774 insertions(+)
>  create mode 100644 Documentation/networking/spi_can.txt
>=20
> diff --git a/Documentation/networking/spi_can.txt b/Documentation/netwo=
rking/spi_can.txt
> new file mode 100644
> index 0000000..82f33e7
> --- /dev/null
> +++ b/Documentation/networking/spi_can.txt
> @@ -0,0 +1,774 @@
> +The spi_can driver is intended to provide a general protocol
> +to support CAN interface that are not directly connected or
> +part of the main controller, but they are available on a
               M    C
> +separate controller, such as a low cost/low power microcontroller
                      (the CAN Controller),
> +(for example, very simple 16 bit controllers providing multiple CAN
> + busses).
> +
> +This document is intended to describe the internal protocol
> +on the SPI interface between the linux system (main controller)
                                                  M    C
> +and the remote CAN controller(s).
       a              C         ^^^ remove this.
> +
> +1. Overview
> +----------------------
> +

Can you please define what it the:
- CAN Controller
- Main Controller

As far as I understand the Main Controller is the system running Linux,
which has at least a SPI master controller. The CAN Controller is
connected via SPI as a slave to the Main Controller.

> +The CAN controller processors supports up to N Can Busses. The Main Co=
ntroller
   The CAN Controller's processor                 CAN
> +driver should be able to manage all CAN busses. It is then

the

> +responsibility of the SW Main Application to decide which controllers
> +(which CAN channels) should be opened and used.
> +
> +There is the requirement to configure the CAN controller, sending some=

                                                 C
> +parameters or commands not strictly related to the CAN interfaces. For=
 example,
> +it is required that the application sends periodically a message to th=
e CAN
> +controller, that has the responsibility to supervise the Main Controll=
er. If the
   C
> +message is not received in time, the CAN controller must perform a res=
et of the
> +Main Controller controller (Watchdog message).

The CAN Controller will reset the Linux System? I think that should be ou=
t of the
scope of the specification of this interface.

> +Another known use case is to configure the wake-up mechanism, that is
> +under which circumstances the CAN controller must awake the Main Contr=
oller
> +(ignition, opened door,...). The protocol foresees an additional chann=
el (CFG)
> +used to exchange data between the application layer and the CAN contro=
ller.
> +
> +The document sets the rules to exchange messages between the Main Cont=
roller and
> +the CAN controller and allows to extend the functionalities with new m=
essages
> +(see Chapter 5) in the future.
> +
> +2. Interface to upper layer
> +------------------------------
> +
> +The driver must provide a socket CAN interface. In this way, the
> +application is able to communicate with CAN via usual sockets.
> +A detailed description can be found in the kernel documentation
> +(Documentation/networking/can.txt).
> +
> +On the application level there will be network interfaces, and
> +they can be set up with Linux tools such as "ifconfig" and "ip".
> +
> +For the CAN controller configuration it is proposed to add a further n=
etwork
> +device ("cfg") to have a consistent interface. In this way, the
> +driver must not expone itself in a different way to the application SW=
=2E
                   ^^^^^^
expose?

> +Configuration packets are simply forward to the CAN controller exactly=
 as it is
                                    ^^^^^^^
forwarded

> +done for the other channels. The application fills data for the cfg
> +interface and the Main Controller driver does not need to look inside.=

> +Configuration data are treated by the CAN driver exactly as all other =
CAN
> +packets.
> +Only the SW application and CAN controller-SW are aware of it.
> +
> +The driver must be able to mux/demux packets from the socket can inter=
face.
> +Indeed, there is only one SPI interface to to communicate with the CAN=

> +controller, and the driver instantiates automatically multiple network=

> +interfaces.
> +On the downstream direction, the driver must take packets from all int=
erfaces
> +(hcan0,..hcan4), set up a frame header (message type,
> +channel number, etc.) and send it to CAN controller via the SPI interf=
ace.

Why are the normal interfaces named "hcan%d"? Why not keep the usual
name "can%d"?

> +
> +
> +             hcan0  hcan1 hcan2  hcan3  hcan4 cfg
> +               |     |    |       |       |    |
> +               |     |    |       |       |    |
> +            ,__|_____|____|_______|_______|____|_
> +            |                                    |
> +            |                                    |
> +            |      SOCKET CAN (Kernel)           |
> +            |                                    |
> +            L________________,.__________________|
> +                            ,!!;
> +                            ,!!;
> +                            `!!.
> +                            ;!!.
> +            ,'''''''''''''''''''''''''''''''''''`.
> +            |  +------------------------------.  |
> +            |  |    Channel Mux/Demux         |  |
> +            |  L______________________________|  |
> +            |                                    |
> +            |  +------------------------------.  |
> +            |  |       Can to SPI controller  |  |
                          ^^^
CAN

> +            |  L______________________________|  |
> +            |..................................../
> +
> +
> +On the upstream direction, the driver must be able to demux the receiv=
ed
> +frames and forward them to the related network interface.
> +
> +The cfg is a special CAN interface used only to set up the
> +CAN controller behavior and does not map to a physical CAN channel, as=
 the other
> +CAN interfaces do. The scope of such interface is to provide a way to
> +exchange messages with the CAN controller processor that are not stric=
tly
> +related to the CAN bus. As example for such messages, a watchdog messa=
ge must
> +be sent regularly by the Main Controller to the CAN controller, and it=
 is sent
> +as CAN data to channel that matches the imxhcs12.  The driver is not a=
ware of
                                           ^^^^^^^^
Old name leftover?

> +these messages, as they are seen as normal data messages for a CAN cha=
nnel.
> +This guarantees that it is possible in future to extend the list of th=
ese
                                         ^ the
> +configuration messages without changing the driver. The partners that =
must know
> +their format are the application software in user space and the CAN co=
ntroller
> +Software.
> +
> +3. Interface to HW
> +---------------------------
> +
> +The CAN controller is connected to the Main Controller via the SPI int=
erface.
                                                              ^^^
nitpick: "a", usually modern SoCs have more than one SPI controller :)
> +
> +3.1 SPI Hardware Connection
> +---------------------------
> +
> + - Main Controller is always the Master and the CAN controller in slav=
e mode.
                                    ^m                 C
> +
> + - Maximal frequency:
> +   The limit is set by the CAN controller, because it must serve an in=
terrupt
> +   request before the next two bytes are sent.

The maximal frequency is limited by the CAN controller, ...
 - or -
The limit is given by the CAN controller, ...

> +
> +   The CAN controller has two operational modes: "User Mode" and
> +   "Supervisor / Maintenance" Mode. The last one is used to update
> +   the software on the CAN controller.
> +   In Supervisor Mode, the CAN controller runs with little support for=
 its
> +   peripherals. The maximum SPI frequency is limited to 1 Mhz.

The maximum frequency depends on the actual CAN controller, isn't it?

> +   The driver must support two different operational frequencies,
> +   and must be able to switch between them.
> +   This is done using the CFG_MSG_SET for the CFG channel, see details=
 in chapter 6.
> +
> + - bit x words : it was tested with 32 bits. This means that the Main =
Controller
> +   deactive the chip select automatically (without intervention by Sof=
tware)
      ^^^^^^^^
deactivates

> +   each 4 bytes. No interrupts are generated on the Main Controller be=
cause they
> +   are ruled by the internal FIFO.

Why is this point mentioned here?

IIRC this is a non standard mode of SPI operation, usually the chip
select stays active while the communication is taking place with the SPI
slave. Your original code is based on a i.MX SoC, right? IIRC in the
mx35 the chip select generated by the SPI controller has a big
limitation (bug), so we always used the GPIO chip select.

> +
> + - GPIO(s):
> +	IRQ GPIO: set active by CAN controller when it has something to send
> +		it raises an interrupt on Main Controller side.
> +
> +To transfer data, some frame header will be included. If a field conta=
ins more
                     ^^^^ a

> +as one byte, a big endian convention is used (MSB is transmitted first=
).
   ^^
more than

> +
> +The SPI interface is full duplex. This means, both Main Controller and=
 CAN
> +controller are transmitting data at the same time. It is possible to t=
ransfer
> +CAN messages to and from the CAN controller in the same SPI transfer.
> +
> +4. SPI Protocol between Main Controller and CAN controller
> +----------------------------------------------------------
> +
> +The format of the frames exchanged between Main Controller and CAN con=
troller
> +is:
> +
> +
> +    ,'''''''','''''''''''''''','''''''''''''''''''''''','''''''''''''|=

> +    |MSG ID  |  Length(16 bit)|    DATA                |  CHECKSUM   |=

> +    L________|________________|________________________|_____________|=

> +
> +The checksum is thought to be used in the development phase to check
> +for implementation's error. It should be possible to disable it after
                     ^^
just: implementation

> +the development is finished. The SPI interface ensures that data are
> +transfered without modification between the two processors.

I'm not sure if the last sentence is correct. As far as I know there
isn't any bit error detection or correction on a SPI bus.

> +
> +The checksum is computed as 16 bit 2's complement of the sum (module 1=
6)
> +of  all bytes in the message, excluded the checksum itself.
> +On the receive side, it is enough to sum all bytes including the check=
sum
> +to verify if the message was received correctly (the sum must be zero)=
=2E
> +
> +The MSG-ID (1 byte) identifies the type of exchange data. For basic ex=
change
> +of frames, the following messages are used:
> +
> +	SEND_DATA_MSG
> +	STATUS_MSG
> +	SYNC_MSG
> +	CFG_MSG_SET
> +	CFG_MSG_GET
> +	REQ_DATA_MSG
> +
> +The SEND_DATA_MSG is used when one of the two processors needs to send=
 a CAN
> +message.
> +
> +The STATUS_MSG is used to inform the partner about the number of bytes=
 ready
> +to be transfered. This is used by the Main Controller when it has seve=
ral
> +messages to send, and it needs a longer frame as usual to sen all CAN =
messages
                                                             ^^^ send
> +back.

What do you mean by the back in: "send all CAN message _back_"?

> +
> +The SYNC_MSG is used to start up the communication and in case an erro=
r is
> +detected. It is the first message that the Main Controller will send t=
o the
> +CAN controller.                                            ^^^^

Can you use standard https://www.ietf.org/rfc/rfc2119.txt key words when
describing you protocol?

That will translates to MUST.

> +Because the Main Controller will always send the MSG ID as first byte =
in the
> +frame, the SYNC_MSG is used to signalize the start of a frame to the C=
AN
> +controller.

The Main Controller MUST send the MSG ID as the first byte due to the
above defined framing, correct?

> +The SYNC_MSG is used also to initialize or reinitialize the time on th=
e
                   ^^^^^^^^^
also used

> +CAN controller. It is not required to the CAN controller to have an ab=
solute
> +time synchronized to the Main Controller. It is enough to have a relat=
ive time,
> +and the Main Controller computes the absolute time to add it as timest=
amp to
> +the received packets.

Can you rephrase the above two sentences, they read a bit bumpy ;)

> +
> +The CFG_MSG_SET is sent to configure the CAN channel for bitrate and t=
iming.

the bit rate and timing of the CAN channel
 - or -
the CAN channel's bitrate and timing

> +The driver on the Main Controller does not need to parse the parameter=
s and it
replace the "and" by ","
> +forwards them to the corresponding CAN controller's CAN interface.
> +
> +The CFG_MSG_GET is sent at the start up to query the CAN controller ab=
out its
> +internal timing, making them available to the netlink interface. CAN d=
rivers
                           ^^^^ it (the timing - singular)
> +have usually fest values for can_bittiming_const. In case of a remote
                ^^^^ fixed, as Oliver pointed out

> +CAN controller driven via SPI, the Main Controller cannot know the tim=
ing
> +and must ask them to the CAN controller before instantiating a CAN dev=
ice.
                ^^^^^^^ remove
> +For this reason, the message is sent only once in the probe() entry po=
int.
> +
> +The REQ_DATA is sent only by the Main Controller when the Main Control=
ler
> +signals it has packets to be transfered, but the Main Controller has n=
othing
> +to sent. Its scope is mainly to signalize to the Main Controller the S=
tart of

The second and fourth Mail Controller has probably to be replaced by CAN
Controller?

> +the Frame and to pass in the LENGTH field the number of bytes of the f=
rame
> +itself.

Have described the LENGTH field so far? It's probably the size of the
whole frame including MSG_ID and CHECKSUM (if appended).

> +After receiving the REQ_DATA message, the CAN controller knows how man=
y bytes
it is
> +is allowed to send without fragmenting frames on the Main Controller's=
 side.
> +
> +4.1 Start of the comunication
> +-----------------------------
> +
> +The Main Controller does not poll continuosly the CAN controller.
                                     ^^^^^^^^^^^
continuously
> +If it has nothing to send, it waits to get an interrupt on the GPIO-li=
ne.
> +
> +If the CAN controller has packets to be sent, it sets the GPIO-IRQ,
> +and this raises an interrupt on Main Controller side.
   ^^^ remove
> +
                            what do you mean by enough?
                                VVVVVV
> +The CAN controller can sends enough messages as they can fit inside
                          ^^^^^ send
> +the SPI transfer. The number of bytes (=3DSPI clock cycles)

Do you want to say:

The CAN controller can send as many CAN frames as fit inside a SPI transf=
er?

> +to be transfered is set by the Main Controller inside the Status Messa=
ge.
> +

I assume on the left is the Main Controller and on the right we have the
CAN Controller?

> +               |                               |
> +               |GPIO(IRQ for Main Controller)  |
> +               |<------------------------------'
> +               |                               |
> +               |  First SPI Transfer started   |
> +               |      SPI:REQ_DATA             |
> +               |------------------------------>|
> +               |      SPI:Send Data            |
> +               |<------------------------------|
> +               |      SPI:Send Data            |
> +               |<------------------------------|
> +               |      SPI: Status              |
> +               |<------------------------------|
> +               |                               |
> +               |  New SPI Transfer started     |
> +               |      SPI:Send Data            |
> +               |------------------------------>|
> +               |      SPI:Send Data            |
> +               |<------------------------------|
> +               |                               |
> +               |                               |
> +               |                               |
> +	Example of SPI transfer.
> +
> +The CAN controller sets the GPIO-IRQ, and this raises an interrupt on =
the
                                         ^^^ remove
> +Main Controller.
> +The protocol uses several Message-IDs to identify what is really excha=
nged.
> +
> +From the Main Controller point of view, a SPI Transfer is initiated wh=
en the
            Main Controller's
> +first byte is written into the internal FIFO and it is finished when t=
he all

Under Linux a SPI transfer is usually started with spi_sync() or it's
asynchronous variant.

> +bytes are transmitted. The protocol relies on the positional place of =
the
> +bytes, that means there is no need to wait for a start-frame byte.

I don't get the last sentence, maybe it's get more clear later....

> +
> +On the receive side, due to CAN controller limitations, the Main Contr=
oller
> +must drop the first 4 bytes received from the CAN controller, as they =
have
> +no meaning.
> +It must be ensured by the CAN controller software that the first valid=
 byte
> +is the fifth in the SPI transfer.
> +
> +The Main Controller has no knowledge at the beginning how many message=
s the
> +CAN controller will send and it starts with a 32-bytes transfer becaus=
e this
> +matches the internal FIFO and raises only one interrupt.

We should not put any assumptions about the Main Controller's hardware in=
to the
specification of the protocol. Under Linux you can run a (somewhat slow) =
SPI bus
on bit-banged GPIOs. Just specify then length of the SPI frame.

> +If the CAN controller has communicated with the status message
   ^^ After
> +the number of bytes it needs for the next SPI frame, the Main Controll=
er will
> +start a SPI transfer for a number of bytes equal or greater
> +as the received value.
> +Sending imediately a new SPI transfer should minimize the delay to tra=
nsfer
           ^^^^^^^^^^
immediately

> +CAN messages into the socket CAN layer, and setting the transfer to
> +a multiple of 32 is a best-effort for the CPU load on the Main Control=
ler side,

32 bytes

> +because it matches the internal FIFO size (tested on i.MX35). However,=
 there is
                                                                there are=
 ^^^^^^^^
Remove the hardware assumption here please.

> +no restrictions about the number of bytes to be transfered, and it is =
duty of
> +the Main Controller driver to find the most valuable length to be used=
=2E

Earlier you say you have to transfer equal or more bytes as requested, no=
w you
state there aren't any restrictions.

> +
> +A SPI transfer is *NOT* delimited by changes of the chip select signal=
=2E Indeed,
> +the chip select is ruled internally by the bits x word setup, and it i=
s made
> +suitable for both CAN controller and Main Controller. Bits x words mus=
t be a
> +multiple of 2, because the CAN controller gets an interrupt each 2 byt=
es.

Sorry I don't get what you mean...The chip select under Linux is usually
controlled on a struct spi_transfer base with the cs_change member of tha=
t struct.
What you describe sounds like a special hardware feature of the imx35.

> +
> +
> +5. SPI Communication scenarios
> +-------------------------------
> +
> +5.1 The CAN controller wants to send data, no data from Main Controlle=
r
> +----------------------------------------------------------------------=
-
> +
> +The CAN controller sets the GPIO to raise an interrupt on the Main Con=
troller.
           C
> +The CAN controller sets always the GPIO if it has something to sent, a=
nd it is
           C

the duty
> +duty of the Main Controller to disable and enable the interrupt source=
 depending
> +on the status of the transmission.

Transmission of the SPI messages?

> +
> +After getting the interrupt, the Main Controller (that has no knowledg=
e about
> +the amount of data to be transfered from the CAN controller), will sta=
rt a SPI
> +transfer for a total of 32 bytes (default), sending a REQ_DATA message=
=2E

Specify the length or give it a name that is specified later, e.g. in som=
e kind of table.

> +This is the best-effort way for the Main Controller, as it will transf=
er so many
> +bytes as the internal FIFO can, and only one ISR is raised to terminat=
e the
> +transfer.

Remove the assumptions about the hardware on the Main Controller.

> +Taking into account that the header requires 3 bytes (MSG-ID + length)=
 and the
> +checksum further two bytes, there are still 27 bytes available for the=
 CAN
> +messages.

Is the checksum optional or not?
What about the 4 bogus bytes in the beginning of the message?

> +This is always enough to send at least one CAN message.
> +
> +The CAN controller answers with the SEND_DATA_MSG. The Main Controller=
 knows
> +that there is no message from the Main Controller, because the MSG-ID =
is not

The Main Controller knows that there is no message from the Main Controll=
er?

> +set to SEND_DATA, and acquires the number of bytes to be transfered fr=
om the
> +length field.
> +The CAN controller packs so many CAN messages inside the SEND_DATA_MSG=

                            ^^ who many? as many as possible/fit?
> +(usually 1 or 2), delimiting the packet with the checksum as described=
 before.

The checksum was specified as optional?

> +
> +
> + Main Controller       ,''''''''''''''''''''''''''''''''''''''''''''''=
''''|
> + (MOSI)             '''| REQ_DATA                                     =
    |
> +                       |______________________________________________=
____|
> +
> +
> +
> + CAN Contr.,'''''''''''''''''''''',''''''''''''''''''''''''''''|
> + (MISO)    |Do not care (4 bytes) |  Send DATA MSG             |
> +           |                      |                            |
> +           '`''''''''''''''''''''''`''''''''''''''''''''''''''''
> +                              32 bytes long transfer
> +   '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''=
''''
> +
> +There are two options at this point:
> +
> +5.2 The CAN controller has sent all CAN messages.
> +-------------------------------------------------
> +
> +In this case, the CAN controller deasserts the GPIO line to avoid furt=
her
                                                  ^^^^
Better name it IRQ line, it's just an implementation details that it's a =
GPIO on the Can Controller :)

> +interrupts for the Main Controller.

This means the IRQ is level triggered, please specify this when describin=
g the IRQ.

> +
> +5.3 The CAN controller has more data to be sent.
> +------------------------------------------------
> +
> +It can send a STATUS_MSG message, if it fits into the current transfer=
=2E
> +There is no rule about when sending this message. The main constraint =
for
                          ^^^^^^^^^^^^
                          when to send

> +the CAN controller is that the packets must not be fragmented, that is=
, there is
                                                      this means ^^^^^^^
> +still enough place inside the current frame to send the STATUS_MSG.
> +The CAN controller can decide also to send the Status Message before t=
he
> +SEND_DATA_MSG.
> +Anyway, because the length of a STATUS_MSG is fixed (5 bytes), it is s=
ure that
> +the CAN controller is always able to send a SEND_DATA_MSG and a STATUS=
_MSG
> +inside a standard (=3D32 bytes) SPI transfer.

Note: above was the length of 32 a bit vague, now you assume that it's 32=
=2E

> +
> +
> + Main Controller       ,''''''''''''''''''''''''''''''''''''''''''''''=
''''|
> + (MOSI)             '''| REQ_DATA                                     =
    |
> +                       |______________________________________________=
____|
> +
> +
> +CAN Controller   ,'''''''''''''''''''''''''''''',''''''''''''''|
> +                 |   SEND DATA                  |  STATUS      |
> +                 |                              |              |
> +                  `''''''''''''''''''''''''''''''`'''''''''''''
> +
> +
> +After receiving the STATUS_MSG, the Main Controller is aware of the nu=
mber of
> +bytes the S12 wants to send. It starts without waiting for the GPIO-IS=
R
             ^^^
CAN Controller

> +and sends (if it has no messages for the CAN controller) a new REQ_DAT=
A
> +with the length of the SPI transfer, followed by dummies 0x00.
> +The length could be changed by the Main Controller, but it must not be=
 smaller
> +as the value required by the Main Controller in the STATUS_MSG.
   ^^ than                      ^^^^^^^^^^^^^^^ CAN Controller???
> +
> + Main Controller       ,''''''''''''''''''''''''''''''''''''''''''''''=
''''''''|
> + (MOSI)             '''| REQ_DATA                                     =
        |
> +                       |______________________________________________=
________|
> +
> +
> +                  ,''''''''''''''''''''''''''''  ,''''''''''''''''''''=
''''''''',
> +                  |   SEND DATA                  |   SEND DATA        =
         |
> +                  |                              |                    =
         |
> +                   `'''''''''''''''''''''''''''   `'''''''''''''''''''=
''''''''''
> +
> +The CAN controller has now enough SPI clock cycles to send all data
           C
> +to the Main Controller. After sending all data, it will fill also any
> +remaining bytes until the end of transfer with dummy bytes.
                                                  ^^^^^^^^^^^=20
just "0x0", sounds more professional than dummy bytes.

> +
> +In case there is no place for the STATUS_MSG and because it is not all=
owed
> +to fragment packets, the CAN controller must maintain assert the GPIO-=
IRQ line
                                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^
must maintain the IRQ line asserted

> +and wait until the Main Controller will start a new transfer again.
> +
> +5.4 Both CAN controller and Main Controller has data to be sent
                                               ^^^^^^^^^^^^^^^^^^^ have d=
ata to send
> +----------------------------------------------------------------
> +
> +The CAN controller asserts the GPIO line to raise an interrupt. The in=
terrupt
                                  ^^^^ IRQ
> +can be served or not, depending if the Main Controller has already rec=
ognized
> +that it must send data. The GPIO is used from the Main Controller as
> +level-interrupt, and the Main Controller is able to activate it when n=
o transfer
> +is running, and to deactivate it when it already knows there are messa=
ges
> +to be exchanged.
> +
> +The scenario is quite the same as previously:
> +
> +
> +
> +      ,'''''''''''''''''''''''''''''''''''''''''''''''''''''''''|
> +Main  |   SEND DATA                                             | ....=
=2E......
> +      |                                                         |
> +       `''''''''''''''''''''''''''''''`''''''''''''''''''''''''''
> +
> +                  ,'''''''''''''''''''''''''''',
> +CAN Controller    |   SEND DATA                |
> +                  |                            |
> +                   `'''''''''''''''''''''''''''
> +
> +The Main Controller starts with the SEND_DATA_MSG. If it has a lot of =
CAN
> +messages to be sent, it sets accordingly the length field and it packs=
 all CAN
            ^^^^^^^^^^ to send
> +messages inside the same single SEND_DATA_MSG.
> +
> +The CAN Controller, that has something to send, will answer with the
> +SEND_DATA_MSG, too.

If the CAN Controller has something to send, it will ....

> +Because it has already received the length of the incoming message, it=
 is
> +aware about how many bytes are transfered and can act as in 5.3 if it =
has more
> +messages to send.
> +
> +5.5 The CAN controller gets new data during a transfer
               C
> +------------------------------------------------------
> +
> +In this case, there are the following options:
> +
> +- the new messages can be fit inside the actual transfer.
                      ^^^^^^^^^^ fits
> +Then the CAN controller will append a new SEND_DATA_MSG to the end of =
the
> +data that it is currently sending on the SPI line.

What will happen if a new CAN frame comes in while REQ DATA is still runn=
ing,
but the first SEND_DATA is already done and the CAN Controller is already=
 inserting
stuffing/dummy 0x0?

> +
> + Main     ,'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''=
'''''''''|
> + (MOSI) '''| REQ_DATA                                                 =
         |
> +           |__________________________________________________________=
_________|
> +
> +
> +                  ,''''''''''''''''''''''''''''  ,''''''''''''''''''''=
''''''''',
> +CAN Controller    |   SEND DATA                  |   SEND DATA        =
         |
> +                  |                              |                    =
         |
> +                   `'''''''''''''''''''''''''''   `'''''''''''''''''''=
''''''''''
> +			^--at this point, new can message(s) is(are) received
> +
> +- the new messages cannot be fit inside the actual SPI transfer
> +but there is place for a STATUS_MSG.
> +
> +The CAN controller will append a STATUS_MSG after the SEND_DATA as in =
5.3.
> +After receiving STATUS_MSG, the Main Controller will start a new SPI t=
ransfer
> +for the requested amout of data.
> +
> +
> + Main      ,'''''''''''''''''''''''''''''''''''''''''''''''''''|
> + (MOSI) '''| REQ_DATA                                          |
> +           |___________________________________________________|
> +
> +
> +
> +CAN Controller   ,'''''''''''''''''''''''''''''',''''''''''''''|
> +                 |   SEND DATA                  |  STATUS      |
> +                 |                              |              |
> +                  `''''''''''''''''''''''''''''''`'''''''''''''
> +
> +- There is no place for the new message and/or the STATUS_MSG
> +
> +In this case, and because it is not allowed to fragment packets, the C=
AN
> +controller must maintain assert the GPIO-IRQ line and wait until the M=
ain
> +Controller will start a new transfer again.
> +
> +5.6 Communication with upper layer
> +----------------------------------
> +
> +After reception of data, the CAN-Main Controller driver should demux d=
ata and
> +send them to the correct CAN interface via the API provided by socket =
CAN.
> +
> +6. Time synchronization
> +----------------------------
> +
> +As the CAN controller sends a timestamp to the Main Controller, it is =
required
              C
> +to have the same time base. The CAN controller inserts timestamp with =
1mSec
                                       C                                 =
^^^^^ 1ms
> +resolution, because it is programmed with 1mSec timer interrupt.

In the protocol we should not car about the internals of the CAN Controll=
er.

> +This resolution is enough for diagnostic protocols and higher resoluti=
on
> +timestamps are not reliable inside the CAN controller itself.
> +
> +To allow to the Main Controller to compute the absolute time, the Main=

> +Controller and the CAN controller must compute elapsed time from the s=
ame base.
                          C
> +
> +The SYNC_MSG is used to reset the CAN controller's internal counter.
                                         C
> +The Main Controller sends this message at the start up, and it can sen=
d it
> +when there is no traffic to maintain time synchronized.
> +The following actions are taken:
> +
> +1. The Main Controller sends a SYNC_MSG, and stores its absolute time.=


How is the absolute time encoded? ms since 1970? Or ms since an arbitrary=
 value?=20

> +   The SYNC_MSG is sent as single message in a 32 byte transfer.
> +   The remaining bytes are filled with zeros by the Main Controller.
> +   This makes easy to recognize the SYNC_MSG if the snchronization is =
lost.

synchronization

> +2. After receiving the SYNC_MSG, the CAN controller resets its interna=
l
> +   counter to zero.
> +   As the SYNC_MSG is used to signalize the start of frame, the CAN co=
ntroller
> +   synchronize itself for the next transfer.
> +
> +When the CAN controller will send data, it will add the elapsed millis=
econds
> +from the receiving of the SYNC_MSG as timestamps. As 4 bytes are used =
for
   ^^^^ since
> +timestamp, the timestamp will roll over after 1193 days.

-> 2^32 / 1000 / 60 / 60 / 24
 =3D 49.710270

I've calculated 49 days.

> +
> +7. CAN configuration
> +----------------------------------
> +
> +It is foreseen that the CAN controller's CAN channels are configured i=
n the
> +usual way under Linux via the "ip" command. In fact, the CAN interface=
 cannot
> +be set to "up" if it was not configured before.
> +
> +With ip, the following parameters can be set:

This should not be scope of the protocol documentation, just refer the ex=
isting CAN documentation in the kernel.

> +
> +ip link set DEVICE type can
> +	[ bitrate BITRATE [ sample-point SAMPLE-POINT] ] |
> +	[ tq TQ prop-seg PROP_SEG phase-seg1 PHASE-SEG1
> +	  phase-seg2 PHASE-SEG2 [ sjw SJW ] ]
> +
> +	[ loopback { on | off } ]
> +	[ listen-only { on | off } ]
> +	[ triple-sampling { on | off } ]
> +	[ one-shot { on | off } ]
> +	[ berr-reporting { on | off } ]
> +
> +	[ restart-ms TIME-MS ]
> +	[ restart ]
> +
> +	Where: BITRATE       :=3D { 1..1000000 }
> +	       SAMPLE-POINT  :=3D { 0.000..0.999 }
> +	       TQ            :=3D { NUMBER }
> +	       PROP-SEG      :=3D { 1..8 }
> +	       PHASE-SEG1    :=3D { 1..8 }
> +	       PHASE-SEG2    :=3D { 1..8 }
> +	       SJW           :=3D { 1..4 }
> +	       RESTART-MS    :=3D { 0 | NUMBER }
> +
> +After using the ip command, the driver will receive from the socketCAN=
 layer
> +the following structure, defined in include/linux/can/netlink.h:
> +
> +/*
> + * CAN bit-timing parameters
> + *
> + * For futher information, please read chapter "8 BIT TIMING
> + * REQUIREMENTS" of the "Bosch CAN Specification version 2.0"
> + * at http://www.semiconductors.bosch.de/pdf/can2spec.pdf.
> + */
> +struct can_bittiming {
> +        __u32 bitrate;          /* Bit-rate in bits/second */
> +        __u32 sample_point;     /* Sample point in one-tenth of a perc=
ent */
> +        __u32 tq;               /* Time quanta (TQ) in nanoseconds */
> +        __u32 prop_seg;         /* Propagation segment in TQs */
> +        __u32 phase_seg1;       /* Phase buffer segment 1 in TQs */
> +        __u32 phase_seg2;       /* Phase buffer segment 2 in TQs */
> +        __u32 sjw;              /* Synchronisation jump width in TQs *=
/
> +        __u32 brp;              /* Bit-rate prescaler */
> +};
> +
> +The parameters are not interpreted by the driver, but they are encapsu=
lated
> +as they are in a SPI frame with MSG-ID=3DCFG_MSG_SET and sent to the c=
orresponding CAN
> +channel.

This is not a good idea, as a kernel internal change will break your firm=
ware.

> +It is then duty of the CAN controller to set up the hardware on base o=
f
> +the received parameters. According to the rules set in this document,
> +single parameters are sent in a big-endian order (MSB first).
> +
> +A special case is the setup for the CFG channel. This channel is not m=
apped to
> +a real CAN bus, but it is used to instantiate a communication
> +between the CAN controller software and the Application in User Space.=

> +Data are not interpreted at all by the driver, and anybody can set its=
 internal
> +protocol to add commands and features to the CAN controller software.
> +One example is the Watchdog triggering already mentioned.
> +The CAN_MSG is ignored by the CAN controller for the CFG channel, and =
its values
> +do not change the hardware setup.
> +Using this message it is possible to switch the CAN controller between=
 two
> +operational modes:
> +	- Supervisor / Maintenance mode:	slow, max SPI frequency 1 Mhz
> +	- User / Normal mode			max SPI frequency set at startup
> +
> +The driver will start setting the SPI frequency to the lower value.
> +When the CFG channel is opened, the driver checks the bitrate of the
> +can_bittiming structure, and takes the following actions:
> +
> +	- bitrate =3D 125000		sets SPI frequency to low value
> +	- bitrate > 125000		sets SPI frequency to high value

125 kbit/s? Why this arbitrary value?

> +
> +In user space it is then possible to switch the CAN controller between=
 the two
> +operational modes simply issueing the "ip link" command and setting
> +the bitrate for the CFG channel.
> +
> +To set the CAN controller in supervisor mode:
> +	ip link set cfg type can bitrate 125000
> +
> +To set the CAN controller in user mode:
> +	ip link set cfg type can bitrate 500000

Can you come up with a cleaner solution for this problem?

> +
> +
> +8. SPI Frame definition and Messages
> +----------------------------------------
> +
> +A SPI Frame begins with a 4-bytes header:
> +
> +bytes:
> +	0		Message ID
> +	1-2		Message Length.
> +			Length is computed including 2 bytes for checksum,
> +			but without Message ID and Length itself.

So N in this example?

> +	3 .. N-2	Depending on Message-ID
> +	N-1 .. N	Checksum

Is the checksum optional or not?

> +
> +Command codes:
> +	0x01	Status Request
> +	0x02	Send Data
> +	0x03	Sync message
> +	0x04	Configuration Message
> +	....	t.b.d.

Can you please reuse the name you've established before? Like SEND_DATA_M=
SG.
In the beginning of this document there are 6 messages defined.

> +
> +8.1 Format of Send Data Message
> +-------------------------------
> +
> +  _____,________________
> + |     |                ,''''''''''''''''',''''''''''''|       ,''''''=
'|
> + |ID=3D2 | LENGTH         | CAN MESSAGE     |CAN MESSAGE |       |CHEC=
KSUM
> + |_____L________________|_________________|____________|       L______=
_|
> +                     _.-'                  `--._
> +                _,,-'                           ``-.._
> +            _.-'                                      `--._
> +       _,--'                                               ``-.._
> +   ,.-'                                                          `-.._=

> +   ,'''''',''''''''''''','''''''''''''','''''',''''''|     ,'''''''''|=

> +   | CH   |TIMESTAMP    |  CAN ID      |DLC   |D[0]  |     |D[dlc-1] |=

> +   L______L_____________|______________L______|______|     L_________|=

> +
> +
> +	Offset
> +	0		0x02 (SEND_DATA_MSG)
> +	1 - 2		Length of message
> +
> +
> +Each CAN message has the following format
> +
> +	0		Channel Number
> +			Values:
> +			1-n	CAN Channel
> +			0xFF	CFG channel
> +	1 - 4		Timestamp
> +	5 - 8		can_id
> +	9		dlc (length of can message)
> +	10..N		Variable number of data (max 8)
> +
> +Note: Channel 0 is reserved for configuration.

What's Channel 0xff then?

> +
> +The flag for Standard and Extended frame format (SFF and EFF
> +in socketCAN framework) is a flag in the can_id.

Better use a separate define, although these flags are Linux userspace AP=
I/ABI

> +
> +8.2 Format of Status Message
> +----------------------------
> +
> +  _____,________________
> + |     |                ,''''''''''''''''''|'''''''|
> + |ID=3D1 | LENGTH=3D4       | Length (2 bytes) |CHECKSUM
> + |_____L________________|__________________|_______|
> +
> +
> +	Offset
> +	0	0x01 (STATUS_MSG)
> +	1-2	4
> +	3-4	Desired mionimal length for next transfer
minimal
> +	5-6	Checksum
> +
> +8.3 Format of Sync Message
> +--------------------------
> +
> +  _____,________________
> + |     |                ,'''''''''''''''''''|'''''''|
> + |ID=3D3 | LENGTH=3D6       | AA | 55 | 55 | AA |CHECKSUM
> + |_____L________________|____|____|____|____|_______|
> +
> +
> +	Offset
> +	0	0x02 (SYNC_MSG)
> +	1-2	6
> +	3	0xAA
> +	4	0x55
> +	5	0x55
> +	6	0xAA
> +	7-8	Checksum
> +
> +8.5 Format of Set Configuration Message
> +----------------------------------------
> +  _____,________
> + |     |        ,'''''''''''''''''''''''''''''''''''''''''|'''''''''|.=
=2E
> + |ID=3D4 | LEN=3D40 | channel | Enabled  |  bitrate | sample  | tq    =
  |  |CHECKSUM
> + |_____L________|_________|__________|__________|_________|_________..=

> +
> +
> +	Offset
> +	0	0x04 (CFG_MSG_SET)
> +	1-2	36
> +	3	channel number
> +		0xFF =3D CFG
> +		0..n =3D CAN controller CAN channel

Above you've written that 0x0 is special

> +	4	Enabled/disabled
> +		Bit 0 is defined.
> +			0 =3D disabled
> +			1 =3D enabled
> +		bit 1..7 =3D reserved (do not care)
> +	5-8	bitrate
> +	9-12	sample point
> +	13-16	Time quanta (tq)
> +	17-20	Propagation segment
> +	21-24	Phase Buffer segment 1
> +	25-28	Phase Buffer segment 2
> +	29-32	Sync jump width
> +	33-36	Bit rate prescaler
> +	37-40	ctrlmode
> +	41-42	Checksum
> +
> +There is no answer from the CAN controller after receiving a CFG_MSG_S=
ET, and the
> +CAN controller is not allowed to send a data frame in answer to a CFG_=
MSG_SET. After
> +setting the channel, the communication will go on as usual.
> +
> +8.6 Format of REQ_DATA Message
> +------------------------------
> +
> +  _____,________________
> + |     |                ,''''''''''''''''''''''''''|'''''''|
> + |ID=3D5 | LENGTH=3Dn       | 00 | 00 | 00 |           |CHECKSUM
> + |_____L________________|____|____|____|___________|_______|
> +
> +
> +	Offset
> +	0	0x05 (REQ_DATA)
> +	1-2	Length of the message.
> +		This value is not fiixed and tells the CAN controller
fixed                                                      C
> +		how many bytes it can send back

Specify a minimum length here.

> +	3:(n-2)	Filled with zero
> +	(n-1):n	Checksum
> +
> +8.6 Format of Get Configuration Message
> +----------------------------------------
> +
> +Format of the frame sent by Main Controller:
> +  _____,________
> + |     |        ,'''''''''|'''''''''|
> + |ID=3D6 | LEN=3D3  | channel |CHECKSUM |
> + |_____L________|_________|_________|
> +
> +Answer from CAN Controller:
> +  _____,________
> + |     |        ,''''''''''''''''''''|''''''''''|'''''''''|'''''''''|.=
=2E
> + |ID=3D6 | LEN=3D25 | channel |tseg1_min |tseg2_max |tseg2_min|       =
  |CHECKSUM
> + |_____L________|_________|__________|__________|_________|_________..=

> +
> +	Offset
> +	0	0x06 (CFG_MSG_GET)
> +	1-2	25
> +	3	channel number
> +		0xFF =3D CFG
> +		0..n =3D CAN controller CAN channel
> +	5	tseg1_min
> +	6	tseg1_max
> +	7	tseg2_min
> +	8	tseg2_max
> +	9	sjw_max
> +	10-13	brp_min
> +	14-17	brp_max
> +	18-21	brp_inc
> +	22	ctrlmode
> +	23-27	clock
> +	28-29	Checksum
> +
> +The CAN controller answers after receiving a CFG_MSG_GET with the can =
bittiming and
> +capabilities. The meaning of bittiming is as explained in netlink.h fo=
r
> +struct can_bittiming_const.
> +
> +ctrlmode contains the CAN controller capabilities. It is a wired-or by=
te, whose bits
> +are defined in netlink.h.
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |



--TnUnEv5XXaHOMCm6jjhF2rPuaNhkmsK4o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUWhXHAAoJECte4hHFiupUvf0QAKsFe11yVZtTMNiTra6HYeLS
5wxtz0OTfiDa0Et5cBFhfkrpOpGJB6HtUrA2qBSNVbplYeHO+M6QXNDIhfs47Kp7
0aAC3v7KXK+EgvlrHrDLI5GlxqvIxkOespqOom6bINfgo+9jUQrZT2ofKwCP1MSL
vO1aC8lq05hdDUaM446ZJ667NyuyyEOnLzC9Fwr6DA8xB2reXwl2CrRdlqkCtkZZ
heRlkDbbaNmRb7AFJDLeuQ619MiYtlIg3U1UHRv/Gg3GghABMRS3R0OREQVDKafW
kCYDlz+HhrkfAEnAnTTSZkpnZl2xgJi82I17BkeDn3wOmv8o6ZS9YuxBJkmx5bZ0
onrfsA7MbODM4398DrQgYk3PEBJx1MQ6k35DGj4XX/TQlIRomhDaHa4EBLduZpcw
5njp5TjBR6HBNCPjw3ZB/dY8pvUXBpYH2+pQ0VbKTuFXE+D2elPDJUZvFzanACTq
DWN/h30lp2WABE0VvFadFg5Sls9JhiAGKUuEltkjzdMKAg42K1XPpiWxI0UKulGf
hCOKe3yqE54ZUFg/mujvPTmQrcohiUx9+Ax7Ug9HJHpQRwyBrcXlxgrKWnEacoBo
2SCEyegW7KfCNOKk3s5L1+wmbKTHJ8TeNWBqgFQhCyH2UrgHQChEcP8HuSP/qbtZ
r7P2ZtElPEhu+jLujaWf
=5Rmt
-----END PGP SIGNATURE-----

--TnUnEv5XXaHOMCm6jjhF2rPuaNhkmsK4o--
