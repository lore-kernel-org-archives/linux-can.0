From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Dropped Tx frames with SJA1000
Date: Thu, 28 Jul 2016 08:08:02 +0200
Message-ID: <caed996e-2c8e-f54d-78ba-d69ab4361ae6@grandegger.com>
References: <CABeNA8droHfwjaTkqnjbJBZTmETy_n58QDxFq9dne9w1EcjyHQ@mail.gmail.com>
 <111f48cb-d8e6-67fc-9644-389f342601cb@optusnet.com.au>
 <CABeNA8dX7GRTDO+1wgz3Wv9v-n4U5tnpHJUHi=V_G57PtXVyCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy01.manitu.net ([217.11.48.140]:37201 "EHLO
	mailproxy01.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163053AbcG1GII (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Jul 2016 02:08:08 -0400
In-Reply-To: <CABeNA8dX7GRTDO+1wgz3Wv9v-n4U5tnpHJUHi=V_G57PtXVyCQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Damien Dusha <d.dusha@gmail.com>, tom_usenet@optusnet.com.au
Cc: linux-can@vger.kernel.org

Hello,

Am 28.07.2016 um 00:47 schrieb Damien Dusha:
> Hi Tom,
>
> On Wed, Jul 27, 2016 at 5:17 PM, Tom Evans <tom_usenet@optusnet.com.au> wrote:
>> On 27/07/16 16:23, Damien Dusha wrote:
>>>
>>> Dear linux-can,
>>>
>>> I am attempting to debug an issue with the SJA1000 driver. The symptom
>>> is the occasional dropped frame when transmitting a burst of frames.
>>> Reception is unaffected.
>>
>> * What are you setting "/sys/class/net/can0/tx_queue_len" to?
>
> [damien@localhost can-utils]$ cat /sys/class/net/can0/tx_queue_len
> 1000
>
> The test sends 640 messages (20 bursts of 32 messages).
>
>> * Are your tools (cangen et al) making a "setsockopt(s, SOL_SOCKET,
>> SO_SNDBUF, &buflen)" call with a sensible value? What do they do when they
>> get ENOBUFS?
>
> cangen is from the standard CAN utilities, which may be found at:
> git clone https://github.com/linux-can/can-utils.git
>
>> http://socket-can.996257.n3.nabble.com/Solving-ENOBUFS-returned-by-write-td2886.html
>
> I'm not convinced is the ENOBUFS problem.  When strace is performed on
> the process, all writes are returned successfully, but the message
> never makes it to the hardware.
>
> The entire strace is shown below where message with ID = 0x0A was
> dropped, Note all 32 write() calls are successful.
>
> execve("./cangen", ["./cangen", "can0", "-g", "0", "-Ii", "-Di",
> "-Li", "-n", "32"], [/* 33 vars */]) = 0
> brk(NULL)                               = 0x9606000
> mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
> 0) = 0xb7723000
> access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
> open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
> fstat64(3, {st_mode=S_IFREG|0644, st_size=98687, ...}) = 0
> mmap2(NULL, 98687, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb76e3000
> close(3)                                = 0
> open("/lib/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
> read(3, "\177ELF\1\1\1\3\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000\207\1\0004\0\0\0"...,
> 512) = 512
> fstat64(3, {st_mode=S_IFREG|0755, st_size=2111020, ...}) = 0
> mmap2(NULL, 1894876, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
> 3, 0) = 0xb7514000
> mprotect(0xb76dc000, 4096, PROT_NONE)   = 0
> mmap2(0xb76dd000, 12288, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1c8000) = 0xb76dd000
> mmap2(0xb76e0000, 10716, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb76e0000
> close(3)                                = 0
> mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
> 0) = 0xb7513000
> set_thread_area({entry_number:-1, base_addr:0xb7513700, limit:1048575,
> seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1,
> seg_not_present:0, useable:1}) = 0 (entry_number:6)
> mprotect(0xb76dd000, 8192, PROT_READ)   = 0
> mprotect(0x804d000, 4096, PROT_READ)    = 0
> mprotect(0xb7724000, 4096, PROT_READ)   = 0
> munmap(0xb76e3000, 98687)               = 0
> rt_sigaction(SIGTERM, {0x8049610, [TERM], SA_RESTART}, {SIG_DFL, [], 0}, 8) = 0
> rt_sigaction(SIGHUP, {0x8049610, [HUP], SA_RESTART}, {SIG_DFL, [], 0}, 8) = 0
> rt_sigaction(SIGINT, {0x8049610, [INT], SA_RESTART}, {SIG_DFL, [], 0}, 8) = 0
> socket(AF_CAN, SOCK_RAW, 1)             = 3
> ioctl(3, SIOCGIFINDEX, {ifr_name="can0", }) = 0
> setsockopt(3, 0x65 /* SOL_?? */, 1, NULL, 0) = 0
> bind(3, {sa_family=AF_CAN,
> sa_data="\0\0\3\0\0\0\320\257p\267\350[r\267"}, 16) = 0
> write(3, "\0\0\0\0\1\0\0\0\0\0\0\0\0\0\0\0", 16) = 16
> write(3, "\1\0\0\0\1\0\0\0\1\0\0\0\0\0\0\0", 16) = 16
> write(3, "\2\0\0\0\2\0\0\0\2\0\0\0\0\0\0\0", 16) = 16
> write(3, "\3\0\0\0\3\0\0\0\3\0\0\0\0\0\0\0", 16) = 16
> write(3, "\4\0\0\0\4\0\0\0\4\0\0\0\0\0\0\0", 16) = 16
> write(3, "\5\0\0\0\5\0\0\0\5\0\0\0\0\0\0\0", 16) = 16
> write(3, "\6\0\0\0\6\0\0\0\6\0\0\0\0\0\0\0", 16) = 16
> write(3, "\7\0\0\0\7\0\0\0\7\0\0\0\0\0\0\0", 16) = 16
> write(3, "\10\0\0\0\10\0\0\0\10\0\0\0\0\0\0\0", 16) = 16
> write(3, "\t\0\0\0\1\0\0\0\t\0\0\0\0\0\0\0", 16) = 16
> write(3, "\n\0\0\0\1\0\0\0\n\0\0\0\0\0\0\0", 16) = 16
> write(3, "\v\0\0\0\2\0\0\0\v\0\0\0\0\0\0\0", 16) = 16
> write(3, "\f\0\0\0\3\0\0\0\f\0\0\0\0\0\0\0", 16) = 16
> write(3, "\r\0\0\0\4\0\0\0\r\0\0\0\0\0\0\0", 16) = 16
> write(3, "\16\0\0\0\5\0\0\0\16\0\0\0\0\0\0\0", 16) = 16
> write(3, "\17\0\0\0\6\0\0\0\17\0\0\0\0\0\0\0", 16) = 16
> write(3, "\20\0\0\0\7\0\0\0\20\0\0\0\0\0\0\0", 16) = 16
> write(3, "\21\0\0\0\10\0\0\0\21\0\0\0\0\0\0\0", 16) = 16
> write(3, "\22\0\0\0\1\0\0\0\22\0\0\0\0\0\0\0", 16) = 16
> write(3, "\23\0\0\0\1\0\0\0\23\0\0\0\0\0\0\0", 16) = 16
> write(3, "\24\0\0\0\2\0\0\0\24\0\0\0\0\0\0\0", 16) = 16
> write(3, "\25\0\0\0\3\0\0\0\25\0\0\0\0\0\0\0", 16) = 16
> write(3, "\26\0\0\0\4\0\0\0\26\0\0\0\0\0\0\0", 16) = 16
> write(3, "\27\0\0\0\5\0\0\0\27\0\0\0\0\0\0\0", 16) = 16
> write(3, "\30\0\0\0\6\0\0\0\30\0\0\0\0\0\0\0", 16) = 16
> write(3, "\31\0\0\0\7\0\0\0\31\0\0\0\0\0\0\0", 16) = 16
> write(3, "\32\0\0\0\10\0\0\0\32\0\0\0\0\0\0\0", 16) = 16
> write(3, "\33\0\0\0\1\0\0\0\33\0\0\0\0\0\0\0", 16) = 16
> write(3, "\34\0\0\0\1\0\0\0\34\0\0\0\0\0\0\0", 16) = 16
> write(3, "\35\0\0\0\2\0\0\0\35\0\0\0\0\0\0\0", 16) = 16
> write(3, "\36\0\0\0\3\0\0\0\36\0\0\0\0\0\0\0", 16) = 16
> write(3, "\37\0\0\0\4\0\0\0\37\0\0\0\0\0\0\0", 16) = 16
> close(3)                                = 0
> exit_group(0)                           = ?
> +++ exited with 0 +++

What does "ip -d -s link show can0" report? What device are you using to 
monitor/trace the traffic?

Wolfgang.
