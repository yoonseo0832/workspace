import { useEffect, useState } from "react"

export default function FunctionalComponent () {
    const [now, setNow] = useState(null);

    useEffect(()=>{
        console.log("함수형 컴포넌트 생성 시 (Mounting)");

        const timer = setInterval(()=>{
            setNow(new Date());
        }, 1*1000);

        return()=>{
            console.log("함수형 컴포넌트 소멸 시 (Unmounting)");
            clearInterval(timer);
        }
    }, []);

    useEffect(()=>{
        console.log("함수형 컴포넌트 생성 (Mounting) 및 업데이트 시 (Updating)");
    }, [now]);


    return (
        <div className="App">
            {now && now.toLocaleTimeString()}
        </div>
    )
}