From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: Re: Bit rate configuration of PEAK USB devices
Date: Thu, 17 Nov 2011 18:55:04 +0100
Message-ID: <4EC54A78.2060109@grandegger.com>
References: <B3B3BE5A55ED7743A83865E234A22B1D1B91F2BDFE@SBSPORT.portnet.local>	<4EC2AAD8.6080907@hartkopp.net>
	<4EC2B072.5060704@hartkopp.net>	<B3B3BE5A55ED7743A83865E234A22B1D1B91F2BE57@SBSPORT.portnet.local>	<20111117112447.GA366@e-circ.dyndns.org>	<4EC532E9.5050308@hartkopp.net>
	<20111117162535.GF366@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
In-Reply-To: <20111117162535.GF366-MxZ6Iy/zr/UdbCeoMzGj59i2O/JbrIOy@public.gmane.org>
List-Unsubscribe: <https://lists.berlios.de/mailman/options/socketcan-users>,
	<mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.berlios.de/pipermail/socketcan-users>
List-Post: <mailto:socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
List-Help: <mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.berlios.de/mailman/listinfo/socketcan-users>,
	<mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=subscribe>
Sender: socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Errors-To: socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
To: Oliver Hartkopp <socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>, "socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org" <socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>, "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-can.vger.kernel.org

On 11/17/2011 05:25 PM, Kurt Van Dijck wrote:
> On Thu, Nov 17, 2011 at 05:14:33PM +0100, Oliver Hartkopp wrote:
>> On 17.11.2011 12:24, Kurt Van Dijck wrote:
>>
>>> On Thu, Nov 17, 2011 at 07:49:43AM +0100, Heinz-J=FCrgen Oertel wrote:
>>>>
>>>> Danke Oliver,
>>>>
>>>> for now I decided to use something like
>>>>
>>>> system("echo \"i 0x4914 e\" > /dev/pcan0");
>>>>
>>>> Unfortunately at the moment I have  no idea how to determine if I'm ju=
st talking to an Peak or an EMS interface  to select the method of setting =
the bit rate.
>>>
>>> Maybe
>>>
>>> $ ip -d link show can0
>>>
>>> will show differently?
>>
>>
>> No.
>>
>> The PEAK driver does not use the candev framework (drivers/net/can/dev.c=
).
>> Therefore you won't see anything beyond up/down state and tx_queue_len, =
etc.
>> Not bitrate settings :-(
> My idea was to use this 'lack of information' to auto-decide if it's an E=
MS or PEAK
> interface. But Heinz-J=FCrgen already pointed out that using some /proc f=
ile, you
> can also see if a device is a PEAK device.

The best solution would be to provide a *real* Socket-CAN driver for the
PEAK USB devices instead of continuing with this mixed net-char-dev
crap. Well, it does work basically but it's not what users nowadays want.

Wolfgang.
