From: kedari appana <kedare06-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: CANutilities
Date: Wed, 15 May 2013 13:09:35 +0530
Message-ID: <CANdmM3Mo0q7OpX5-ScnLhtWGEiPBvgeKx9SPe=+KBeABodP46g@mail.gmail.com>
References: <CANdmM3MkAN9tZLUDSnVrdXTngu7CH5UESUAo7NO4u85D0Hg2tQ@mail.gmail.com>
	<5193360F.3040609@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
In-Reply-To: <5193360F.3040609-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.berlios.de/mailman/options/socketcan-users>,
	<mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.berlios.de/pipermail/socketcan-users>
List-Post: <mailto:socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
List-Help: <mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.berlios.de/mailman/listinfo/socketcan-users>,
	<mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=subscribe>
Sender: socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Errors-To: socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
To: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org, "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-can.vger.kernel.org

Hi Marc,
I am running as a root.my hardware don't support triple sampling mode
is there any issue with that?

Regards,
Kedar.

On Wed, May 15, 2013 at 12:45 PM, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> On 05/15/2013 09:00 AM, kedari appana wrote:
>> Hi,
>>                      when i try to run the below command i am getting the error
>> ./canconfig can0 bitrate 100000 ctrlmode triple-sampling on loopback on
>> 1c
>> can0 bitrate: 100000, sample-point: 0.875
>> RTNETLINK answers: Operation not supported
>> can0: failed to set ctrlmode
>>
>> How to overcome it
>
> Are you running canconfig as root?
>
> Marc
>
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>
