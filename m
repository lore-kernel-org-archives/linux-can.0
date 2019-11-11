From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: INFO: task hung in vivid_stop_generating_vid_cap
Date: Mon, 11 Nov 2019 15:00:57 +0100
Message-ID: <64d6d60b-bf1c-5fee-7049-9998afa0b91a@xs4all.nl>
References: <000000000000c9f0a40596c1d46b@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000000000000c9f0a40596c1d46b@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: syzbot <syzbot+06283a66a648cd073885@syzkaller.appspotmail.com>, andy@greyhouse.net, davem@davemloft.net, dvyukov@google.com, hans.verkuil@cisco.com, helen.koike@collabora.com, hverkuil@xs4all.nl, j.vosburgh@gmail.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, maheshb@google.com, mchehab+samsung@kernel.org, mchehab@kernel.org, mchehab@s-opensource.com, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, tfiga@chromium.org, vfalico@gmail.com
List-Id: linux-can.vger.kernel.org

#syz fix: media: vb2: add waiting_in_dqbuf flag
