From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] net: slcan, slip -- no need for goto when if () will do
Date: Tue, 10 Mar 2020 14:07:03 +0100
Message-ID: <0d9a5f11-1dc9-03ad-cecb-af38ad421c95@hartkopp.net>
References: <20200309223323.GA1634@duo.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200309223323.GA1634@duo.ucw.cz>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org, yangerkun@huawei.com, davem@davemloft.net, mkl@pengutronix.de, wg@grandegger.com
List-Id: linux-can.vger.kernel.org



On 09/03/2020 23.33, Pavel Machek wrote:
> 
> No need to play with gotos to jump over single statement.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
> index 2f5c287eac95..686d853fc249 100644
> --- a/drivers/net/can/slcan.c
> +++ b/drivers/net/can/slcan.c
> @@ -348,11 +348,8 @@ static void slcan_write_wakeup(struct tty_struct *tty)
>   
>   	rcu_read_lock();
>   	sl = rcu_dereference(tty->disc_data);
> -	if (!sl)
> -		goto out;
> -
> -	schedule_work(&sl->tx_work);
> -out:
> +	if (sl)
> +		schedule_work(&sl->tx_work);
>   	rcu_read_unlock();
>   }

Haha. Yes, that looks indeed much better ...

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

>   
> diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
> index babb01888b78..f81fb0b13a94 100644
> --- a/drivers/net/slip/slip.c
> +++ b/drivers/net/slip/slip.c
> @@ -456,11 +456,8 @@ static void slip_write_wakeup(struct tty_struct *tty)
>   
>   	rcu_read_lock();
>   	sl = rcu_dereference(tty->disc_data);
> -	if (!sl)
> -		goto out;
> -
> -	schedule_work(&sl->tx_work);
> -out:
> +	if (sl)
> +		schedule_work(&sl->tx_work);
>   	rcu_read_unlock();
>   }
>   
> 
