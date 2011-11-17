From: Oliver Hartkopp <socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>
Subject: Re: Bit rate configuration of PEAK USB devices
Date: Thu, 17 Nov 2011 17:11:09 +0100
Message-ID: <4EC5321D.7030604@hartkopp.net>
References: <B3B3BE5A55ED7743A83865E234A22B1D1B91F2BDFE@SBSPORT.portnet.local>
	<4EC2AAD8.6080907@hartkopp.net> <4EC2B072.5060704@hartkopp.net>
	<B3B3BE5A55ED7743A83865E234A22B1D1B91F2BE57@SBSPORT.portnet.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
In-Reply-To: <B3B3BE5A55ED7743A83865E234A22B1D1B91F2BE57-E+xEQJb9ENTWDPv2tuTBK42P0GrZ+RbP@public.gmane.org>
List-Unsubscribe: <https://lists.berlios.de/mailman/options/socketcan-users>,
	<mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.berlios.de/pipermail/socketcan-users>
List-Post: <mailto:socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
List-Help: <mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.berlios.de/mailman/listinfo/socketcan-users>,
	<mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=subscribe>
Sender: socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Errors-To: socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
To: =?ISO-8859-1?Q?Heinz-J=FCrgen_Oertel?= <oe-pJ9TYRvN+WE@public.gmane.org>
Cc: "socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org" <socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>, "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-can.vger.kernel.org

On 17.11.2011 07:49, Heinz-J=FCrgen Oertel wrote:

> =

> On 15.11.2011 19:33, Oliver Hartkopp wrote:
> =

>> I forgot to mention that you can also use the PCAN ioctl() interface on =
the
>> PEAK chardevices or their pcanlib ...
>>
> =

> Danke Oliver,
> =

> for now I decided to use something like
> =

> system("echo \"i 0x4914 e\" > /dev/pcan0");
> =

> Unfortunately at the moment I have  no idea how to determine if I'm just =
talking to an Peak or an EMS interface  to select the method of setting the=
 bit rate.


An idea is to write different udev rules due to the different USB Vendor ID=
s,
that do the initialization in different manners.

If you want to set the default bitrate for all PEAK devices, you can set the
global default bitrate on the module commandline.

Regards,
Oliver
