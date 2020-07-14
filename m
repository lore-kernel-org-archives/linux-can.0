From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH net-next] can: silence remove_proc_entry warning
Date: Tue, 14 Jul 2020 22:10:04 +0200
Message-ID: <e2344833-b2f4-cc6f-4b6c-868afc3ced6e@hartkopp.net>
References: <1594709090-3203-1-git-send-email-zhangchangzhong@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1594709090-3203-1-git-send-email-zhangchangzhong@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Changzhong <zhangchangzhong@huawei.com>, mkl@pengutronix.de, davem@davemloft.net, kuba@kernel.org
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org



On 14.07.20 08:44, Zhang Changzhong wrote:
> If can_init_proc() fail to create /proc/net/can directory,
> can_remove_proc() will trigger a warning:
> 
> WARNING: CPU: 6 PID: 7133 at fs/proc/generic.c:672 remove_proc_entry+0x17b0
> Kernel panic - not syncing: panic_on_warn set ...
> 
> Fix to return early from can_remove_proc() if can proc_dir
> does not exists.
> 
> Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks!

> ---
>   net/can/proc.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/can/proc.c b/net/can/proc.c
> index e6881bf..077af42 100644
> --- a/net/can/proc.c
> +++ b/net/can/proc.c
> @@ -471,6 +471,9 @@ void can_init_proc(struct net *net)
>    */
>   void can_remove_proc(struct net *net)
>   {
> +	if (!net->can.proc_dir)
> +		return;
> +
>   	if (net->can.pde_version)
>   		remove_proc_entry(CAN_PROC_VERSION, net->can.proc_dir);
>   
> @@ -498,6 +501,5 @@ void can_remove_proc(struct net *net)
>   	if (net->can.pde_rcvlist_sff)
>   		remove_proc_entry(CAN_PROC_RCVLIST_SFF, net->can.proc_dir);
>   
> -	if (net->can.proc_dir)
> -		remove_proc_entry("can", net->proc_net);
> +	remove_proc_entry("can", net->proc_net);
>   }
> 
