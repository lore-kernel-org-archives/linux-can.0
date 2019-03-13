From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: WARNING in hsr_forward_skb
Date: Wed, 13 Mar 2019 19:22:54 +0100
Message-ID: <cc1224f9-8fdc-ed08-3004-ae528dbeadb8@hartkopp.net>
References: <0000000000004cfa120583e1dfc3@google.com>
 <7dd5ffca-803d-9d5e-7fa4-f9eed2249d26@hartkopp.net>
 <CACT4Y+ZoDc=_a_W=wVMYj+VLW8WFBDbQJGB17dZTSvYinWhebA@mail.gmail.com>
 <CACT4Y+ayyFe6oek8MdnUd1LsB_+1kpJatBLnmF_jCttQPyCK0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CACT4Y+ayyFe6oek8MdnUd1LsB_+1kpJatBLnmF_jCttQPyCK0g@mail.gmail.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+fdce8f2a8903f3ba0e6b@syzkaller.appspotmail.com>, arvid.brodin@alten.se, Jens Axboe <axboe@fb.com>, Jens Axboe <axboe@kernel.dk>, David Miller <davem@davemloft.net>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Ming Lei <ming.lei@redhat.com>, Marc Kleine-Budde <mkl@pengutronix.de>, netdev <netdev@vger.kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>
List-Id: linux-can.vger.kernel.org

Hi Dimitry,

On 3/12/19 5:21 PM, Dmitry Vyukov wrote:

>> You can see how bisection progressed and got to 4.12.0-rc2+ in the
>> bisection log.
>>
>> The commit that it come up with looks unrelated.
>> I've started collecting such cases at:
>> https://github.com/google/syzkaller/issues/1051
>> and added for this case:
>>
>> =====
>> Bisected to wrong commit.
>> Root cause: broken kernel boots, bugs that happen on all tests.
>> Boot is broken for several releases with "WARNING in hsr_forward_skb",
>> this switches to a bug that happens during every test "INFO: trying to
>> register non-static key in can_notifier", which then leads to a
>> completely random commit.
>> =====
> 
> Broken boots did not happen here. "WARNING in hsr_forward_skb" is the
> crash that we pursued, so it started correctly. But then diverged to
> an unrelated "INFO: trying to register non-static key in
> can_notifier".

Thanks for the clarification! I really appreciate your effort with syzbot!

Best,
Oliver
