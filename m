From: =?iso-8859-1?Q?Heinz-J=FCrgen_Oertel?= <oe-pJ9TYRvN+WE@public.gmane.org>
Subject: Re: Bit rate configuration of PEAK USB devices
Date: Thu, 17 Nov 2011 07:49:43 +0100
Message-ID: <B3B3BE5A55ED7743A83865E234A22B1D1B91F2BE57@SBSPORT.portnet.local>
References: <B3B3BE5A55ED7743A83865E234A22B1D1B91F2BDFE@SBSPORT.portnet.local>
	<4EC2AAD8.6080907@hartkopp.net> <4EC2B072.5060704@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
In-Reply-To: <4EC2B072.5060704-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>
Content-Language: de-DE
List-Unsubscribe: <https://lists.berlios.de/mailman/options/socketcan-users>,
	<mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.berlios.de/pipermail/socketcan-users>
List-Post: <mailto:socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
List-Help: <mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.berlios.de/mailman/listinfo/socketcan-users>,
	<mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=subscribe>
Sender: socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Errors-To: socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
To: Oliver Hartkopp <socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>
Cc: "socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org" <socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>, "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-can.vger.kernel.org


On 15.11.2011 19:33, Oliver Hartkopp wrote:

> I forgot to mention that you can also use the PCAN ioctl() interface on the
> PEAK chardevices or their pcanlib ...
>

Danke Oliver,

for now I decided to use something like

system("echo \"i 0x4914 e\" > /dev/pcan0");

Unfortunately at the moment I have  no idea how to determine if I'm just talking to an Peak or an EMS interface  to select the method of setting the bit rate.

 Regards
 Heinz
